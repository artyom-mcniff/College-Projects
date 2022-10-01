<?php session_start(); ?>
<html>
<body>
<?php
function process_input($data) {
	$data = trim($data);
	$data = stripslashes($data);
	$data = htmlspecialchars($data);
	return $data;
}

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

//Check connection
if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
}

$s = $_SESSION['searchcategory'];
if ( isset($_POST['searchcat'])) {
	$s = process_input($_POST['searchcat']);
	
	switch ($search) {
		case "Book Title":
			$sql = "SELECT bookTitle FROM Books WHERE bookTitle LIKE '%$s%' ";
			break;
		
		case "Author":
			$sql = "SELECT bookTitle FROM Books WHERE author LIKE '%$s%'";
			break;
		
		case "Book Title/Author":
			$sql = "SELECT bookTitle FROM Books WHERE bookTitle LIKE
			'%$s%' OR author LIKE '%$s%'";
			break;
		
		case "Category":
			$sql = "SELECT bookTitle FROM Books WHERE bookCategory LIKE '%$s%'";
			break;
		
		default:
			echo "Something went wrong, try again";
	}
	
	
	
}
	
	$conn->close();


?>

<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
<input type="text" name="searchcat" value="<?php echo $s;?>">
<p><input type="submit" value="Enter"/></p>
</form>
</body>
</html>