<?php
session_start();
$databasename="hotel_management"; //database name
$conn=new mysqli("localhost","root","Mysql@123",$databasename,"3307");
//include 'date.php';
if($conn->connect_error) // connecting
{
	die("Connection failed:".$conn->connect_error);
}
//echo"Connected succesfully ";

if(isset($_POST['fname']))
{
	$fName=$_POST['fname'];
}

if(isset($_POST['lname']))
{
	$lName=$_POST['lname'];
}

if(isset($_POST['email']))
{
	$Email=$_POST['email'];
}

if(isset($_POST['phone']))
{
	$Phone=$_POST['phone'];
}

if(isset($_POST['age']))
{
	$Age=$_POST['age'];
}

//echo $fName;
//echo $lName;
//echo $Email;
//echo $Phone;
//echo $Age;
//include date.php;
$day_in = $_SESSION['inday'];
$month_in =$_SESSION['inmonth'];
$year_in = $_SESSION['inyear'];
$day_out = $_SESSION['outday'];
$month_out = $_SESSION['outmonth'];
$year_out = $_SESSION['outyear'];
$roomtype = $_SESSION['roomtype'];
//echo $roomtype;
//echo $day_in;
//echo $month_in;
//echo $year_in;
//echo $_SESSION['inday'];
//echo $_SESSION['inmonth'];
//echo $_SESSION['inyear'];
//echo $_SESSION['outday'];
//echo $_SESSION['outmonth'];
//echo $_SESSION['outyear'];

$room_no=-1;
$sql ="SELECT room_no,type,available FROM room;"; //query that is to be passed to the database,
$result=$conn->query($sql); //passing the query and storing result in variable result
while($row=$result->fetch_assoc()) //traversion in db row by row
{
	if($row['available']==1 && $row['type']==$roomtype)
	{
		$room_no=$row['room_no'];
		break;
	}
}

$b = rand(1000000, 20000000);//rand(pow(10, $digits-1), pow(10, $digits)-1);

$updateroom ="UPDATE room SET available = '0' WHERE room_no = '$room_no';";
$conn->query($updateroom);

$customer="INSERT INTO customer (age,first_name,c_id,last_name,address,email,BookingID) VALUES ('$Age' ,'$fName' ,'$Phone', '$lName' ,' ' , '$Email', '$b');";
$conn->query($customer);


$booking ="INSERT INTO advance_bookings (day_in,month_in,year_in,day_out,month_out,year_out,room_no,c_id,BookingID) VALUES ('$day_in' ,'$month_in', '$year_in', '$day_out' , '$month_out', '$year_out', '$room_no', '$Phone' , '$b');";
$conn->query($booking);

$log = "INSERT INTO `log` (day_in,month_in,year_in,day_out,month_out,year_out,room_no,c_id,BookingID) VALUES ('$day_in' ,'$month_in', '$year_in', '$day_out' , '$month_out', '$year_out', '$room_no', '$Phone', '$b');";
$conn->query($log);
echo "<br>";
echo "<br>";
echo '<div style="font-size:1.1em;color:#ff577f;font-weight:bold">Your booking is CONFIRMED!! Email has been sent!!</div>';
//echo " Your booking is CONFIRMED!! Email has been sent!! ";
$a = "Booking dates are "  .$day_in ."-".$month_in."-".$year_in. " to " .$day_out."-".$month_out."-".$year_out. " Your BookingID is ";
$msg = $a.$b ;
echo '<div> <span style="font-size:1.1em;color:#ff577f;font-weight:bold;">'.$msg.'</span></div>';


mail($Email,"Villa-Booking Confirmation",$msg,"From: villaindianapolis@gmail.com");


readfile ('Confirmation.html');
?>
