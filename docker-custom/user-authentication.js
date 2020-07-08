let ActiveDirectory = require('activedirectory');
let ad = new ActiveDirectory({
	url: 'ldap://tbisusdc00301.atlascopco.group',
	baseDN: 'DC=atlascopco,DC=group',
	username: 'TBI_IntranetApps_svc@atlascopco.group',
	password: 'kx?re8&Hn9G%QyFn2V'
});

module.exports = {
	type: "credentials",
	users: function(username) {
		return new Promise(function(resolve) {
			// Do whatever work is needed to check username is a valid user.
			let user = {
				username: username,
				permissions: "*"
			}

			switch(username.toLowerCase()){
				case 'paul.wieland@atlascopco.com':
				case 'brian.dodd@atlascopco.com':
				case 'daniel.giese@atlascopco.com':
				case 'spencer.lee@atlascopco.com':
					resolve(user);
					break;
				default: resolve(null);
			}
		});
	},
	authenticate: function(username, password) {
		return new Promise(function(resolve) {
			// Do whatever work is needed to validate the username/password
			// combination.
			let valid = false;
			
			ad.authenticate(username, password, function(err, auth) {
				if (err){
					// console.log('ERROR: ' + JSON.stringify(err));
					resolve(null);
					return;
				}

				if (auth) {
					valid = true;
					var user = {
						username: username,
						permissions: "*"
					}
					console.log(`Authenticated ${username}`);
					resolve(user);
				} else {
					console.log('Authentication failed!');
					resolve(null);
				}
			});
		});
	},
	default: function() {
		return new Promise(function(resolve) {
			// Resolve with the user object for the default user.
			// If no default user exists, resolve with null.
			resolve(null);
		});
	}
}
