module.exports = (grunt, vars, utils) ->
	return {
		server:
			options:
        port: 4000
        base: 'public'
        hostname: '*'
        livereload: true
	}