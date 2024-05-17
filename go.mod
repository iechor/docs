module github.com/iechor/docs

go 1.21

toolchain go1.21.1

require (
	github.com/iechor/buildx v0.14.0 // indirect
	github.com/iechor/cli v26.1.3-0.20240513184838-60f2d38d5341+incompatible // indirect
	github.com/iechor/compose/v2 v2.27.0 // indirect
	github.com/iechor/scout-cli v1.8.0 // indirect
	github.com/moby/buildkit v0.13.1 // indirect
	github.com/moby/moby v26.1.2+incompatible // indirect
)

replace (
	github.com/iechor/buildx => github.com/iechor/buildx v0.14.0
	github.com/iechor/cli => github.com/iechor/cli v26.1.3-0.20240513184838-60f2d38d5341+incompatible
	github.com/iechor/compose/v2 => github.com/iechor/compose/v2 v2.27.0
	github.com/iechor/scout-cli => github.com/iechor/scout-cli v1.8.0
	github.com/moby/buildkit => github.com/moby/buildkit v0.13.0-rc3.0.20240424175633-5fce077ed0e0
	github.com/moby/moby => github.com/moby/moby v26.1.2+incompatible
)
