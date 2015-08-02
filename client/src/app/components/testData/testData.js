(function() {
  'use strict';

  angular
    .module('client')
    .factory('testData', testData);

  /** @ngInject */
  function testData($log, $http, API) {
    var apiHost = API;

    var service = {
      get: get,
    };

    return service;

    function get(callback) {
      return $http.get(apiHost + 'test')
        .then(getComplete);

      function getComplete(response) {
        return callback(response);
      }
    }
  }
})();
