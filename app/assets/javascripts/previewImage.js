$(function(){
  //id（#js-image-preview）をeachで回しても要素は一つしか取得できない。複数要素にidをつけたとしても。classなら要素を複数取れる。
  $('.js-image-preview').each(function(){
    var prototype_image = $(this).find('input[type=file]');
    var image_tag = $(this).find('img');

    prototype_image.change(function(e){
      var file = e.target.files[0];//eachのindexじゃダメ。常に0
      var reader = new FileReader();

      reader.readAsDataURL(file);
      reader.onload = function(){
        image_tag.attr("src",reader.result)
      }
    });
  });
});
