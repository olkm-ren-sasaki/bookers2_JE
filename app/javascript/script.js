$(document).on('turbolinks:load', function() {
  $(function () {

      // スライダー
      $('#slider').slick({
          autoplay: true, // 自動再生
          dots: true, // ドット上のナビを表示
          arrows: true, // 前/次にスライドを切り替える矢印
          // fade: true, // スライドをフェードイン・フェードアウト
          cssEase: 'linear',
          infinite: true,
          slidesToShow: 3,
          slidesToScroll: 1

          // responsive: [{
          // breakpoint: 768, // ブレイクポイントを指定
          //     settings: {
          //     slidesToShow: 2,
          //     speed: 600,
          //     },
          // },
          // {
          // breakpoint: 480,
          //     settings: {
          //     slidesToShow: 1,
          //     centerMode: true,
          //     centerPadding: '20%',
          // },
          // },
          // ]
              });


      // jspostal
      $('#postal_code').jpostal({
          postcode: ['#postal_code'],
          address: {
            '#prefecture_code': '%3',
            '#address_city': '%4',
            '#address_street': '%5%6%7',
          },
        });
  });
});