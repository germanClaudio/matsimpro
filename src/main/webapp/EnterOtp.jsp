<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="css/estiloForgotPass.css"/>
        <title>OTP Password MatSimPro</title>
        <script src="https://kit.fontawesome.com/618299664c.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <!-- Include the above in your HEAD tag -->

        <style>
            .form-gap {
                margin: 70px auto auto auto; 
                padding-top: 70px;
            }
        </style>
    </head>

    <body>
        <div class="form-gap"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="text-center">
                                <h3><i class="fa fa-lock fa-4x"></i></h3>
                                <h2 class="text-center mb-3">Enter OTP</h2>
                                <%
                                    if(request.getAttribute("message")!=null)
                                    {
                                        out.print("<p class='text-danger ml-1'>" + request.getAttribute("message") + "</p>");
                                    }
                                %>
                                <div class="panel-body">
                                    <form method="POST" action="ValidateOtp" id="register-form" role="form" autocomplete="off" class="form">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
                                                <input id="opt" name="otp" placeholder="Enter OTP" class="form-control" type="text" required="required">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <button name="recover-submit" class="btn btn-lg btn-primary btn-block" type="submit" data-bs-toggle="modal">Reset Password <i class="fa fa-unlock"></i> </button>
                                            <a href="login.jsp" class="btn btn-danger my-5" title="Volver"> Volver a Login <i class="fa fa-arrow-circle-left"></i></a>
                                        </div>
                                        <input type="hidden" class="hide" name="token" id="token" value="">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>