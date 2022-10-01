<?php session_start(); ?>
<html>
<head>
<title> Artyom's Library - Search </title>
<!-- <link rel="stylesheet" type="text/css" href="Assets/CSS/site.css"> -->
</head>
<header>
<h2> Artyom's Library </h2>
	<nav>
	<ul>
	<li><a href="search.php">Search</a></li>
	<li><a href="view.php">View</a></li>
	</ul>

	</nav>
</header>
<body>
<?php
require_once "mysqlconnect.php";
require_once "searchform.php";
$t = $empty = "";
$errFlag = 0;

if ( isset($_POST['title'])) {
	if (empty($_POST['title'])) {
		$empty = "Please enter a search query";
		$errFlag = 1;
	} else {
		$t = process_input($_POST['title']);
	}
	
	if ($errFlag != 1){
		$sql = "SELECT bookTitle FROM Books WHERE bookTitle LIKE '%$t%' OR author LIKE '%$t%'";
		$result = $conn->query($sql);
			if ($result->num_rows > 0){
				while($row = $result->fetch_assoc()) {
					echo "Book title " . $row['bookTitle'] . 
					"<a href=reserve.php?title=" . urlencode($row['bookTitle']) . ">Reserve</a>"
					. "<br>";
				}
			}
			else{
				echo"0 results";
			}
	}
	$conn->close();
}


?>
<p> Search By: </p>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
<select name="searchby" value="">
<option value="Title">Title</option>
<option value="Author">Author</option>
<option value="Title and Author">Title and Author</option>
<option value="Category">Category</option>
</select>
<p><input type="submit" value="Enter"/></p>
</form>


<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
<input type="text" name="title" value="<?php echo $t; ?>">
<span class="errorMessage"><?php echo $empty;?></span>
<p><input type="submit" value="Search"/></p>
</form>
