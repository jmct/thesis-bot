<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>{{title}}</title>
<!--    <script language="javascript" type="text/javascript">
      {{#include}}js/jquery-2.1.1.min.js{{/include}}
    </script>
    <script language="javascript" type="text/javascript">
      {{#include}}js/jquery.flot-0.8.3.min.js{{/include}}
    </script>
    <script language="javascript" type="text/javascript">
      {{#include}}js/jquery.criterion.js{{/include}}
    </script>
    <style type="text/css">
-->
{{#include}}progress.css{{/include}}
<link rel="stylesheet" type="text/css" href="progress.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script language="javascript" type="text/javascript" src="jquery.flot.min.js"></script>
<script language="javascript" type="text/javascript" src="jquery.flot.time.js"></script>


 </head>
 <body>

 <div id="wrap">
  <div id="main" class="body">
  <h1>{{subtitle}}</h1>

   <h2>Overview</h2>

    <div id="wordcount" style="width:600px;height:300px"></div>
   
    <p> <a href={{url}}> Current draft. </a></p> 

   <script type="text/javascript">
   var data = {{data}};
   $(function () {
       var plot = $.plot("#wordcount", [{label: "Word Count", data: data}], {legend: {position: "nw"}, xaxis: {mode: "time"}, grid: {hoverable: true}});
    });
   </script>
 </body>

</html>
