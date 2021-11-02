<?php
include_once 'db.php';
session_start();

if (isset($_POST['login'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];

    if (!$email && !$password) {
        header('Location:login.php?empty');
    } else {
        $password = md5($password);
        $query = "SELECT * FROM user WHERE username = '$email' OR email='$email' AND password='$password'";
        $result = mysqli_query($connection, $query);
        if (mysqli_num_rows($result) == 1) {
            $user = mysqli_fetch_assoc($result);
            $_SESSION['username'] = $user['username'];
            $_SESSION['user_id'] = $user['id'];
            header('Location:index.php?dashboard');
        } else {
            header('Location:login.php?loginE');
        }
    }
}

if (isset($_POST['add_room'])) {
    $room_type_id = $_POST['room_type_id'];
    $room_no = $_POST['room_no'];

    if ($room_no != '') {
        $sql = "SELECT * FROM room WHERE room_no = '$room_no'";
        if (mysqli_num_rows(mysqli_query($connection, $sql)) >= 1) {
            $response['done'] = false;
            $response['data'] = "Room No Already Exist";
        } else {
            $query = "INSERT INTO room (room_type_id,room_no) VALUES ('$room_type_id','$room_no')";
            $result = mysqli_query($connection, $query);

            if ($result) {
                $response['done'] = true;
                $response['data'] = 'Successfully Added Room';
            } else {
                $response['done'] = false;
                $response['data'] = "DataBase Error";
            }
        }
    } else {

        $response['done'] = false;
        $response['data'] = "Please Enter Room No";
    }

    echo json_encode($response);
}

if (isset($_POST['room'])) {
    $room_id = $_POST['room_id'];

    $sql = "SELECT * FROM room WHERE room_id = '$room_id'";
    $result = mysqli_query($connection, $sql);
    if ($result) {
        $room = mysqli_fetch_assoc($result);
        $response['done'] = true;
        $response['room_no'] = $room['room_no'];
        $response['room_type_id'] = $room['room_type_id'];
    } else {
        $response['done'] = false;
        $response['data'] = "DataBase Error";
    }

    echo json_encode($response);
}

if (isset($_POST['edit_room'])) {
    $room_type_id = $_POST['room_type_id'];
    $room_no = $_POST['room_no'];
    $room_id = $_POST['room_id'];

    if ($room_no != '') {
        $query = "UPDATE room SET room_no = '$room_no',room_type_id = '$room_type_id' where room_id = '$room_id'";
        $result = mysqli_query($connection, $query);

        if ($result) {
            $response['done'] = true;
            $response['data'] = 'Successfully Edit Room';
        } else {
            $response['done'] = false;
            $response['data'] = "DataBase Error";
        }

    } else {

        $response['done'] = false;
        $response['data'] = "Please Enter Room No";
    }

    echo json_encode($response);
}

if (isset($_GET['delete_room'])) {
    $room_id = $_GET['delete_room'];
    $sql = "UPDATE room set deleteStatus = '1' WHERE room_id = '$room_id' AND status IS NULL";
    $result = mysqli_query($connection, $sql);
    if ($result) {
        header("Location:index.php?room_mang&success");
    } else {
        header("Location:index.php?room_mang&error");
    }
}

if (isset($_POST['booking'])) {
    $room_id = $_POST['room_id'];
    $check_in = $_POST['check_in'];
    $check_out = $_POST['check_out'];
    $total_price = $_POST['total_price'];
    $name = $_POST['name'];
    $contact_no = $_POST['contact_no'];
    $email = $_POST['email'];
    $id_card_id = $_POST['id_card_id'];
    $id_card_no = $_POST['id_card_no'];
    $address = $_POST['address'];

    $customer_sql = "INSERT INTO customer (customer_name,contact_no,email,id_card_type_id,id_card_no,address) VALUES ('$name','$contact_no','$email','$id_card_id','$id_card_no','$address')";
    $customer_result = mysqli_query($connection, $customer_sql);

    if ($customer_result) {
        $customer_id = mysqli_insert_id($connection);
        $booking_sql = "INSERT INTO booking (customer_id,room_id,check_in,check_out,total_price,remaining_price) VALUES ('$customer_id','$room_id','$check_in','$check_out','$total_price','$total_price')";
        $booking_result = mysqli_query($connection, $booking_sql);
        if ($booking_result) {
            $room_stats_sql = "UPDATE room SET status = '1' WHERE room_id = '$room_id'";
            if (mysqli_query($connection, $room_stats_sql)) {
                $response['done'] = true;
                $response['data'] = 'Successfully Booking';
            } else {
                $response['done'] = false;
                $response['data'] = "DataBase Error in status change";
            }
        } else {
            $response['done'] = false;
            $response['data'] = "DataBase Error booking";
        }
    } else {
        $response['done'] = false;
        $response['data'] = "DataBase Error add customer";
    }

    echo json_encode($response);
}

if (isset($_POST['cutomerDetails'])) {
    //$customer_result='';
    $room_id = $_POST['room_id'];

    if ($room_id != '') {
        $sql = "SELECT * FROM room NATURAL JOIN room_type NATURAL JOIN booking NATURAL JOIN customer WHERE room_id = '$room_id' AND payment_status = '0'";
        $result = mysqli_query($connection, $sql);
        if ($result) {
            $customer_details = mysqli_fetch_assoc($result);
            $id_type = $customer_details['id_card_type_id'];
            $query = "select id_card_type from id_card_type where id_card_type_id = '$id_type'";
            $result = mysqli_query($connection, $query);
            $id_type_name = mysqli_fetch_assoc($result);
            $response['done'] = true;
            $response['customer_id'] = $customer_details['customer_id'];
            $response['customer_name'] = $customer_details['customer_name'];
            $response['contact_no'] = $customer_details['contact_no'];
            $response['email'] = $customer_details['email'];
            $response['id_card_no'] = $customer_details['id_card_no'];
            $response['id_card_type_id'] = $id_type_name['id_card_type'];
            $response['address'] = $customer_details['address'];
            $response['remaining_price'] = $customer_details['remaining_price'];
        } else {
            $response['done'] = false;
            $response['data'] = "DataBase Error";
        }

        echo json_encode($response);
    }
}