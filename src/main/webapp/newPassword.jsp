<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="images/FondoSplash_2.ico" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">    
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <title>Reset Password - MatSimPro</title>
        <script src="https://kit.fontawesome.com/618299664c.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
        <style>
            .placeicon {
                font-family: fontawesome
            }

            .custom-control-label::before {
                background-color: #dee2e6;
                border: #dee2e6
            }
        </style>
    </head>
    <script type="text/javascript">
                    function validate_passwordLenght() {
                        var password = document.getElementById('password1').value;
                        
                        if (password.length < 6) {
                            document.getElementById('message4').style.color = 'red';
                            document.getElementById('message4').innerHTML 
                              = '☒ La Contraseña debe tener al menos 6 caracteres';
                            document.getElementById('submit').disabled = true;
                            document.getElementById('submit').style.opacity = (0.4);
                        } else {
                            document.getElementById('message4').style.color = 'green';
                            document.getElementById('message4').innerHTML 
                              = '🗹 Largo de Contraseña aceptable!';
                        }
                    }
                    
                    function validate_password() {
                        var pass = document.getElementById('password1').value;
                        var confirm_pass = document.getElementById('passwordConf1').value;
                        
                        if (pass != confirm_pass) {
                            document.getElementById('message3').style.color = 'red';
                            document.getElementById('message3').innerHTML = '☒ Confirme la Contraseña';
                            document.getElementById('message5').style.color = 'red';
                            document.getElementById('message5').innerHTML 
                              = '☒ Confirme la Contraseña';
                            document.getElementById('submit').disabled = true;
                            document.getElementById('submit').style.opacity = (0.4);
                        } else {
                            document.getElementById('message3').style.color = 'green';
                            document.getElementById('message3').innerHTML = '🗹 Las Contraseñas coinciden!!';
                            document.getElementById('message5').style.color = 'green';
                            document.getElementById('message5').innerHTML = '🗹 Las Contraseñas coinciden!!';
                            document.getElementById('submit').disabled = false;
                            document.getElementById('submit').style.opacity = (1);
                        }
                    }

                    function wrong_pass_alert() {
                        if (document.getElementById('password1').value != "" && document.getElementById('passwordConf1').value != "") {
                            alert("La contraseña se generó exitosamente!!!");
                        } else {
                            alert("Por favor, complete todos los campos!!!");
                        }
                    }
    </script> 
    <body oncontextmenu='return false' class='snippet-body bg-info'>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-social/5.1.1/bootstrap-social.css">
        <div>
            <!-- Container containing all contents -->
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 mt-5">
                        <!-- White Container -->
                        <div class="container bg-white rounded mt-2 mb-2 mx-auto">
                            <!-- Main Heading -->
                            <div class="row justify-content-center pt-3 mx-auto">
                                <h1><strong>Reset Password</strong></h1>
                            </div>
                            <%
                                if(request.getAttribute("message")!=null)
                                {
                                    out.print("<p class='text-danger ml-1'>" + request.getAttribute("message") + "</p>");
                                }
                            %>
                            <div class="pt-3 pb-3">
                                <form method="POST" action="NewPassword" class="form-horizontal">
                                    <!-- User Name Input -->
                                    <div class="form-group row justify-content-center">
                                        <div class="col-9 px-0">
                                            <input type="text" name="password" id="password1" placeholder="&#xf084; &nbsp; Nuevo Password" class="form-control border-info placeicon" onkeyup="validate_passwordLenght()">
                                            <span id="message3" style="color:red"> </span> <br>
                                            <span id="message4" style="color:red"> </span> 
                                        </div>
                                    </div>
                                    <!-- Password Input -->
                                    <div class="form-group row justify-content-center">
                                        <div class="col-9 px-0">
                                            <input type="password" name="confPassword" id="passwordConf1" placeholder="&#xf084; &nbsp; Confirmar Nuevo Password" class="form-control border-info placeicon" onkeyup="validate_password()">
                                            <span id="message5" style="color:red"> </span>
                                        </div>
                                    </div>

                                    <!-- Log in Button -->
                                    <div class="form-group row justify-content-center">
                                        <div class="col-5 mt-3 mx-auto">
                                            <button type="submit" id="submit" class="btn btn-block btn-info my-2" style="width:180px" onclick="wrong_pass_alert()">Reset Password! <i class="fa fa-key"></i></button>
                                            <a href="login.jsp" class="btn btn-danger my-2" title="Volver" style="width:180px"> Volver a Login <i class="fa fa-arrow-circle-left"></i></a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <p class="footer mx-auto text-center">Developed by Germán Montalbetti ©2022</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'></script>

    </body>
</html>