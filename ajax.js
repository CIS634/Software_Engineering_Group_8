$('#addRoom').submit(function () {
    var room_type_id = $('#room_type_id').val();
    var room_no = $('#room_no').val();

    $.ajax({
        type: 'post',
        url: 'ajax.php',
        dataType: 'JSON',
        data: {
            room_type_id: room_type_id,
            room_no: room_no,
            add_room: ''
        },
        success: function (response) {
            if (response.done == true) {
                $('#addRoom').modal('hide');
                window.location.href = 'index.php?room_mang';
            } else {
                $('.response').html('<div class="alert bg-danger alert-dismissable" role="alert"><em class="fa fa-lg fa-warning">&nbsp;</em>' + response.data + '</div>');
            }
        }
    });

    return false;
});

$('#roomEditFrom').submit(function () {
    var room_type_id = $('#edit_room_type').val();
    var room_no = $('#edit_room_no').val();
    var room_id = $('#edit_room_id').val();

    $.ajax({
        type: 'post',
        url: 'ajax.php',
        dataType: 'JSON',
        data: {
            room_type_id: room_type_id,
            room_no: room_no,
            room_id: room_id,
            edit_room: ''
        },
        success: function (response) {
            if (response.done == true) {
                $('#editRoom').modal('hide');
                window.location.href = 'index.php?room_mang';
            } else {
                $('.response').html('<div class="alert bg-danger alert-dismissable" role="alert"><em class="fa fa-lg fa-warning">&nbsp;</em>' + response.data + '</div>');
            }
        }
    });

    return false;
});

$(document).on('click', '#cutomerDetails', function (e) {
    e.preventDefault();

    var room_id = $(this).data('id');
    // alert(room_id);
    console.log(room_id);

    $.ajax({
        type: 'post',
        url: 'ajax.php',
        dataType: 'JSON',
        data: {
            room_id: room_id,
            cutomerDetails: ''
        },
        success: function (response) {


            if (response.done == true) {


                $('#customer_name').html(response.customer_name);
                $('#customer_contact_no').html(response.contact_no);
                $('#customer_email').html(response.email);
                $('#customer_id_card_type').html(response.id_card_type_id);
                $('#customer_id_card_number').html(response.id_card_no);
                $('#customer_address').html(response.address);
                $('#remaining_price').html(response.remaining_price);

            } else {


                $('.edit_response').html('<div class="alert bg-danger alert-dismissable" role="alert"><em class="fa fa-lg fa-warning">&nbsp;</em>' + response.data + '</div>');
            }
        }
    });

});

$('#advancePayment').submit(function () {

    var booking_id = $('#getBookingID').val();
    var advance_payment = $('#advance_payment').val();

    $.ajax({
        type: 'post',
        url: 'ajax.php',
        dataType: 'JSON',
        data: {
            booking_id: booking_id,
            advance_payment: advance_payment,
            check_in_room:''
        },
        success: function (response) {
            if (response.done == true) {
                $('#checkIn').modal('hide');
                window.location.href = 'index.php?room_mang';
            } else {
                $('.payment-response').html('<div class="alert bg-danger alert-dismissable" role="alert"><em class="fa fa-lg fa-warning">&nbsp;</em>' + response.data + '</div>');
            }
        }
    });

    return false;
});

$('#addEmployee').submit(function () {

    var staff_type = $('#staff_type').val();
    var shift = $('#shift').val();
    var first_name = $('#first_name').val();
    var last_name = $('#last_name').val();
    var contact_no = $('#contact_no').val();
    var id_card_id = $('#id_card_id').val();
    var id_card_no = $('#id_card_no').val();
    var address = $('#address').val();
    var salary =$('#salary').val();
        }
    });

    return false;
});

$(document).on('click', '#complaint', function (e) {
    e.preventDefault();

    var complaint_id = $(this).data('id');
    console.log(complaint_id);
    $('#complaint_id').val(complaint_id);

});

$(document).on('click', '#change_shift', function (e) {
    e.preventDefault();

    var emp_id = $(this).data('id');
    console.log(emp_id);
    $('#getEmpId').val(emp_id);

});