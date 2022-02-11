$(document).ready(function()
  {
  
    $('ul#top-user-tabb li').click(function()
	{
		$('ul').find('li').removeClass('active')
		$(this).addClass("active")
		
		$('.profile-viewed-most').hide()
		$(   '#d_'     +      $(this)     .attr('id')     ).show()
		
	});
	
	
	$('ul#top-comm-tabb li').click(function()
	{
		$('ul').find('li').removeClass('active1')
		$(this).addClass("active1")
		
		$('.gradeblock').hide()
		$(   '#c_'     +      $(this)     .attr('id')     ).show()
		
	});
	
	
	
  });