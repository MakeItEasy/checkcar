$(function() {
  // mask的使用，比如手机号码输入的mask 99999999999
  $("[data-mask]").inputmask();
});

// 以下是测试unmask
  /*
  $("#admin_telephone").inputmask('9999-9999', {'autoUnmask' : true, "clearIncomplete": true,
    'onUnMask': function(maskedValue, unmaskedValue) {
      // alert(unmaskedValue);
          return unmaskedValue;
          }});
  $("#admin_telephone").inputmask('99999999', {'autoUnmask' : true, "clearIncomplete": true})

  $("form.mask-form").submit(function() {
    // $("#admin_telephone").unmask();
    // alert($("#admin_telephone").val());
    $("#admin_telephone").attr('value', $("#admin_telephone").val());
    // alert($("#admin_telephone").attr('value'));

    var tbDate = document.getElementById("admin_telephone");
    // tbDate.value = $("#admin_telephone").val();
    // alert($("#admin_telephone").get(0).value = $("#admin_telephone").val());
    $("#admin_telephone").get(0).value = $("#admin_telephone").val();
    // alert(tbDate.value);  
    // $("#admin_telephone").val('1111111');
    // $("#admin_telephone").unmask();
    /*
    $("[data-mask]").each(function(){
      alert('test');
      this.unmask();
    });
    return false;
  });
    */
