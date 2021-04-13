#!/bin/bash
set -eo pipefail

declare -A compose=(
	[debian]='debian'
	#[alpine]='alpine'
)

declare -A base=(
	[debian]='debian'
	#[alpine]='alpine'
)

variants=(
	debian
	#alpine
)

min_version='5.21'
dockerLatest='latest'
dockerDefaultVariant='debian'


# version_greater_or_equal A B returns whether A >= B
function version_greater_or_equal() {
	[[ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || "$1" == "$2" ]];
}

dockerRepo="monogramm/docker-osrm-backend"
# Retrieve automatically the latest versions
latests=( $( curl -fsSL 'https://api.github.com/repos/Project-OSRM/osrm-backend/tags' |tac|tac| \
	grep -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | \
	sort -urV )
	latest)
#latests=( 1.0.0 )

# Remove existing images
echo "reset docker images"
#find ./images -maxdepth 1 -type d -regextype sed -regex '\./images/[[:digit:]]\+\.[[:digit:]]\+' -exec rm -r '{}' \;
rm -rf ./images/*

echo "update docker images"
travisEnv=
for latest in "${latests[@]}"; do
	version=$(echo "$latest" | cut -d. -f1-2)

	# Only add versions >= "$min_version"
	if version_greater_or_equal "$version" "$min_version"; then

		for variant in "${variants[@]}"; do
			echo "Updating $latest [$version-$variant]"

			# Create the version directory with a Dockerfile.
			dir="images/$version/$variant"
			if [ -d "$dir" ]; then
				continue
			fi
			mkdir -p "$dir"

			template="Dockerfile.${base[$variant]}"
			cp "template/$template" "$dir/Dockerfile"
			cp "template/entrypoint.sh" "$dir/entrypoint.sh"

			cp "template/.dockerignore" "$dir/.dockerignore"
			cp -r "template/hooks" "$dir/"
			cp -r "template/test" "$dir/"
			cp "template/.env" "$dir/.env"
			cp "template/docker-compose_${compose[$variant]}.yml" "$dir/docker-compose.test.yml"

			# Replace the variables.
			if [ "$latest" = 'latest' ]; then
				sed -ri -e '
					s/%%VERSION%%/'"$latest"'/g;
				' "$dir/Dockerfile"
			else
				sed -ri -e '
					s/%%VERSION%%/'v"$latest"'/g;
				' "$dir/Dockerfile"
			fi

			sed -ri -e '
				s/%%VARIANT%%/-'"$variant"'/g;
			' "$dir/Dockerfile"

			sed -ri -e '
				s|DOCKER_TAG=.*|DOCKER_TAG='"$version"'|g;
				s|DOCKER_REPO=.*|DOCKER_REPO='"$dockerRepo"'|g;
			' "$dir/hooks/run"

			# Create a list of "alias" tags for DockerHub post_push
			if [ "$version" = "$dockerLatest" ]; then
				if [ "$variant" = "$dockerDefaultVariant" ]; then
					echo "$latest-$variant $version-$variant $variant $latest $version latest " > "$dir/.dockertags"
				else
					echo "$latest-$variant $version-$variant $variant " > "$dir/.dockertags"
				fi
			else
				if [ "$variant" = "$dockerDefaultVariant" ]; then
					echo "$latest-$variant $version-$variant $latest $version " > "$dir/.dockertags"
				else
					echo "$latest-$variant $version-$variant " > "$dir/.dockertags"
				fi
			fi

			# Add Travis-CI env var
			travisEnv='\n    - VERSION='"$version"' VARIANT='"$variant$travisEnv"

			if [[ $1 == 'build' ]]; then
				tag="$version-$variant"
				echo "Build Dockerfile for ${tag}"
				docker build -t "${dockerRepo}:${tag}" "$dir"
			fi
		done
	fi

done

# update .travis.yml
travis="$(awk -v 'RS=\n\n' '$1 == "env:" && $2 == "#" && $3 == "Environments" { $0 = "env: # Environments'"$travisEnv"'" } { printf "%s%s", $0, RS }' .travis.yml)"
echo "$travis" > .travis.yml
