/* Define custom server-side HTTP routes for lineman's development server
 *   These might be as simple as stubbing a little JSON to
 *   facilitate development of code that interacts with an HTTP service
 *   (presumably, mirroring one that will be reachable in a live environment).
 *
 * It's important to remember that any custom endpoints defined here
 *   will only be available in development, as lineman only builds
 *   static assets, it can't run server-side code.
 *
 * This file can be very useful for rapid prototyping or even organically
 *   defining a spec based on the needs of the client code that emerge.
 *
 */

module.exports = {
  drawRoutes: function(app) {
     app.get('/api/v1/colleges', function(req, res){
       res.json(
        [
          {name: 'OSU', id: 1, resources: { players: '/api/v1/colleges/1/players' } },
          {name: 'MSU', id: 2, resources: { players: '/api/v1/colleges/2/players' } }
        ]);
     });
     
     app.get('/api/v1/colleges/1/players', function(req, res){
       res.json(
        [
          {name: 'John Doe', id: 1, resources: { college: '/api/v1/colleges/1' } },
          {name: 'Jane Doe', id: 2, resources: { college: '/api/v1/colleges/1' } }
        ]);
     });
     
     app.get('/api/v1/colleges/2/players', function(req, res){
       res.json(
        [
          {name: 'Jimmy Smith', id: 3, resources: { college: '/api/v1/colleges/2' } },
          {name: 'Tammy Robertson', id: 4, resources: { college: '/api/v1/colleges/2' } }
        ]);
     });
     
     /*
     app.get('/api/v1/colleges/3/players', function(req, res){
       res.json(
        [
          {name: 'Misty Mist', id: 5, resources: { college: '/api/v1/colleges/3' } },
          {name: 'Slammy Sammy', id: 6, resources: { college: '/api/v1/colleges/3' } }
        ]);
     });
     */
     app.post('/api/v1/colleges', function(req, res) {
       var id = 3;
       if ( req.body.name === 'OSU') id = 1;
       if ( req.body.name === 'MSU') id = 2;
       var player = '/api/v1/colleges/' + id + '/players';
       
	   res.json({name: req.body.name, id: id, resources: { players: player }});
     });
     
     app.post('/api/v1/colleges/2/players', function(req, res) {
       var id = 3;
	   res.json({name: req.body.name, id: id, resources: { college: '/api/v1/colleges/2' }});
     });
     
     app.delete('/api/v1/colleges/1', function(req, res) {
	   res.json();
     });
     
     app.delete('/api/v1/colleges/2', function(req, res) {
	   res.json();
     });
     
     app.delete('/api/v1/colleges/3', function(req, res) {
	   res.json();
     });
  }
};