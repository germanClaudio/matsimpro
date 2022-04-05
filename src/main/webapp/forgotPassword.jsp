
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
        <title>Forgot Password MatSimPro</title>
        <script src="https://kit.fontawesome.com/618299664c.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    </head>
    <body oncontextmenu='false' class="snippet-body">
        <div class="container pb-3 mb-2 mt-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <div class="forgot">
                        <h2>Olvidaste tu password?</h2>
                        <p>Recupera tu password en tres simples pasos. Esto te ayudará a asegurar tu password!</p>
                        <ol class="list-unstyled">
                            <li><span class="text-primary text-medium">1.</span> Ingresa tu dirección de email debajo.</li>
                            <li><span class="text-primary text-medium">2.</span> Nuestro sistema te enviará un OTP a su email.</li>
                            <li><span class="text-primary text-medium">3.</span> Ingrese el OTP en la siguiente hoja.</li>
                        </ol>
                    </div>
                    <form method="POST" action="ForgotPassword" class="card mt-5">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="email-for-pass">Ingrese dirección de email</label>
                                <input class="form-control" type="text" name="email" id="email-for-pass" required="">
                                <small class="form-text text-muted">Ingrese su dirección de email. Luego le enviaremos el OTP a esa dirección.</small>
                            </div>
                        </div>
                        <div class="card-footer text-center">
                            <button type="submit" class="btn btn-success me-4" id="botonGenerar" name="GenerarPassword" data-bs-toggle="modal">Generar Nuevo Password <i class="fa-solid fa-key"></i></button>
                            <a href="login.jsp" class="btn btn-danger" title="Volver"> Volver a Login <i class="fa fa-arrow-circle-left"></i></a>
                        </div>
                    </form>
                    <p class="footer text-center">Developed by Germán Montalbetti ©2022</p>
                </div>
                
            </div>
        </div>
        <script 
            src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'>
        </script>
    </body>
</html>
