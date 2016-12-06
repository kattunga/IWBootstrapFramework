# Bootstrap-Dynamic-Tabs

Bootstrap Dynamic Tabs automatically makes Bootstrap nav-tabs and nav pils responsive.

## Requirements
- Bootstrap: 3+
- jQuery: 1.9+

## Usage

```
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Dynamic Tabs</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="bootstrap-dynamic-tabs.css">
  <script src="bootstrap-dynamic-tabs.js"></script>
</head>
<body>
<div class="container">
  <h3>Tabs</h3>
  <ul id="mytabs" class="nav nav-tabs">
    <li class="active"><a href="#">Home</a></li>
    <li><a href="#">Menu 1</a></li>
    <li><a href="#">Menu 2</a></li>
    <li><a href="#">Menu 3</a></li>
    <li><a href="#">Menu 4</a></li>
    <li><a href="#">Menu 5</a></li>
    <li><a href="#">Menu 6</a></li>
  </ul>
  $("#mytabid").bootstrapDynamicTabs();
</div>

</body>
</html>
```

## demo
http://cdn.rawgit.com/kattunga/Bootstrap-Dynamic-Tabs/v2.1/demo.html

## Credits
This proyect is based in the original proyect from: https://github.com/gabrieltomescu/bootstrap-responsive-tabs

## License
The Bootstrap Responsive Tabs plugin is licensed under the MIT license. See the LICENSE file for full details.
