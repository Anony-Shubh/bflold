<!-- Copyright 2011 jQuery4u.com -->
<!DOCTYPE html>
<html>
<title>jQuery Function Demo - jQuery4u.com</title>
<head>
   <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="js/ajaxscript.js"></script>
 
    <script type="text/javascript">
 
    var JQFUNCS =
    {
        runFunc:
        {
            /* ------------------------------ ajax Demo ------------------------------ */
            "ajax":
            {
                run: function(id)
                {
                    $('#'+id+' .content1').bind('click', function(e)
                    {
                        e.preventDefault();
                        getContent('abc.html');
                    });
 
                    $('#'+id+' .content2').bind('click', function(e)
                    {
                        e.preventDefault();
                        getContent('pmegpdashboardmr.jsp');
                    });
 
                    $('#'+id+' .content3').bind('click', function(e)
                    {
                        e.preventDefault();
                        getContent('/function-demos/functions/ajax/data/content3.html');
                    });
 
                    function getContent(filename)
                    {
                        $.ajax({
                            url: filename,
                            type: 'GET',
                            dataType: 'html',
                            beforeSend: function() {
                                $('#'+id+' .contentarea').html('<img src="ajax-loader.gif" />');
                            },
                            success: function(data, textStatus, xhr) {
 
                                if (filename == '/function-demos/functions/ajax/data/content3.html')
                                {
                                    setTimeout( function() {
                                        $('#'+id+' .contentarea').html(data);
                                    }, 2000);
                                }
                                else
                                {
                                    $('#'+id+' .contentarea').html(data);
                                }
                            },
                            error: function(xhr, textStatus, errorThrown) {
                                $('#'+id+' .contentarea').html(textStatus);
                            }
                        });
                    }
 
                },
 
                reset: function(id)
                {
                    $('#'+id+' .contentarea').html('Please Wait Content will Appear here............');
                    $('#'+id).hide();
                }
            }
        }
    }
 
    </script>
 
</head>
<body>
 
<p><a href="#" id="ajax-demobtn" class="demobtn btn actionr">Run Demo</a> 
<a href="#" id="ajax-codebtn" class="codebtn btn actionr">View Code</a> 
<a href="#" id="ajax-resetbtn" class="resetbtn btn actionr" style="display: none;">Reset</a></p>
<div class="demoarea" id="ajax">
<div class="contentarea" style="border:1px solid orange;padding:10px;margin-bottom:5px;">Content will appear here.</div>
<button class="content1 btn">Load content 1</button> <button class="content2 btn">Load content 2</button> <button class="content3 btn">Load content 3</button></div>
 
</body>
</html>
<!-- Copyright 2011 jQuery4u.com -->