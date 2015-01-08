module.exports = (grunt, vars, utils) ->
	return {
		prebuild: [vars.buildDir]
		postProductionBuildJavascript: utils.loadManifestDependenciesFor("javascript", "public/", true)
	}