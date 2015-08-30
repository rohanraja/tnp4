
<div id="testdiv" style="display:none"></div>


<script type="text/javascript">
  
  var maindata ;

  function searchq(str)
{

  if(str.length > 0 || str == "")
  {
    if(str == "")
      str = "0";

    $.ajax({
    async: "false",
        type: "GET",

  url: '/searcher/searchq/<%= plural_table_name %>/' + str, 
  success: function(data)
    {
      console.log(data);

      maindata = data ;

      $('#testdiv').html(data);

      $('tbody').html($('#testdiv').find('tbody').html());

      $('#testdiv').html('');

    //   $('#head_list li a').eq(0).click();

    }});
  }
}


</script>