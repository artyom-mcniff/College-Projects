<?php
function process_input($data) {
	$data = trim($data);
	$data = stripslashes($data);
	$data = htmlspecialchars($data);
	return $data;
}

// If search category has been entered
if ( isset($_POST['searchby']) && isset($_POST['title'])){
	$search = $_POST['searchby'];
		if (empty($_POST['title'])) {
			$empty = "Please enter a search query";
				$errFlag = 1;
				} else {
					$t = process_input($_POST['title']);
				}
	switch ($search) {
		case "Title":
			// header("Location: searchbyTitle.php");
			if ($errFlag != 1) {
				$sql = "SELECT bookTitle FROM Books WHERE bookTitle LIKE '%$t%' ";
			}
				break;
			
		case "Author":
			// header("Location: searchByAuthor.php");
			if ($errFlag != 1){
				$sql = "SELECT bookTitle FROM Books WHERE author LIKE '%$t%'";
			}
			break;
			
		case "Title and Author":
			// header("Location: searchByTA.php");
			if ($errFlag != 1){
			$sql = "SELECT bookTitle FROM Books WHERE bookTitle LIKE '%$t%' OR author LIKE '%$t%'";
			}
			break;
		/*	
		case "Category":
			header("Location: searchbyCat.php");
			break;
		*/
		default:
			echo "Something went wrong, try again";
		}
		$result = $conn->query($sql);
			if ($result->num_rows > 0){
				while($row = $result->fetch_assoc()) {
					echo "Book Title" . $row['bookTitle'] .
						"<a href=reserve.php?title=" . urlencode($row['bookTitle']) . ">Reserve</a>"
						. "<br>";
					}
				} else {
					echo"0 results";
				}
}

/* search by category */
if ( isset($_POST['searchcat'])) {
	$t = $_POST['searchcat'];
	$sql = "SELECT bookTitle FROM Books WHERE bookCategory = $t";
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
?>