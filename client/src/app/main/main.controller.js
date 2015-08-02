(function() {
  'use strict';

  angular
    .module('client')
    .controller('MainController', MainController);

  /** @ngInject */
  function MainController($timeout, webDevTec, testData) {
    var vm = this;

    testData.get(function(response){
      vm.message = response.data.message;
    });
    vm.awesomeThings = [];
    vm.classAnimation = '';
    vm.creationDate = 1438490718873;

    activate();

    function activate() {
      getWebDevTec();
      $timeout(function() {
        vm.classAnimation = 'rubberBand';
      }, 4000);
    }

    function getWebDevTec() {
      vm.awesomeThings = webDevTec.getTec();

      angular.forEach(vm.awesomeThings, function(awesomeThing) {
        awesomeThing.rank = Math.random();
      });
    }
  }
})();
