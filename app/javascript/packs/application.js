// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application" 
import "@fortawesome/fontawesome-free/js/all"

//= require jquery_ujs
//= require jquery
//= require rails-ujs

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", function(){
// ターボリンクスロード
  $(document).ready(function(){
  
    $('.nav-btn').click(function() {
      // console.log('click!!');
       $('.is-mobile').toggleClass('d-none');
    });
    
    
    // レスポンシブスクロールバー出現のためcssに変更
    // $(function(){
    //   ScrollReveal().reveal('.left', {
    //     duration: 5000,
    //     origin: 'left',
    //     distance: '50px',
    //     reset: true
    //   });
    // });
    
    // $(function(){
    //   ScrollReveal().reveal('.right', {
    //     duration: 5000,
    //     origin: 'right',
    //     distance: '50px',
    //     reset: true
    //   });
    // });
    
    $(window).scroll(function (){
    	$('.fadein').each(function(){
    		var elemPos = $(this).offset().top,
    		scroll = $(window).scrollTop(),
    		windowHeight = $(window).height();
    
    			if (scroll > elemPos - windowHeight + 150){
    				$(this).addClass('scrollin');
    			}
    	});
    });
    
    $(function() {
      $('.a').slick({
        dots: true,
        autoplay: true,
        autoplaySpeed: 6000,
        arrows: false
      });
    });

  });
})
