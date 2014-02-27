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
       res.json([{name: 'OSU', id: 1},{name: 'MSU', id: 2}]);
     });
     app.post('/api/v1/colleges', function(req, res) {
       var id = 3;
       if ( req.body.name === 'OSU') id = 1;
       if ( req.body.name === 'MSU') id = 2;
       
	   res.json({name: req.body.name, id: id});
     });
     app.delete('/api/v1/colleges/1', function(req, res) {
	   res.json();
     });
  }
};