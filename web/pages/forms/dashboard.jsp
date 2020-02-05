<%--
  Created by IntelliJ IDEA.
  User: AKBAR
  Date: 09/01/2020
  Time: 11.41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Monitoring apps | Admin</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="stylesheet" href="../../bower_components/bootstrap/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="../../bower_components/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="../../bower_components/Ionicons/css/ionicons.min.css">
        <link rel="stylesheet" href="../../dist/css/AdminLTE.min.css">
        <link rel="stylesheet" href="../../dist/css/skins/_all-skins.min.css">
        <link rel="stylesheet" href="../../bower_components/morris.js/morris.css">
        <link rel="stylesheet" href="../../bower_components/jvectormap/jquery-jvectormap.css">
        <link rel="stylesheet" href="../../bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
        <link rel="stylesheet" href="../../bower_components/bootstrap-daterangepicker/daterangepicker.css">
        <link rel="stylesheet" href="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <%
            String auth = session.getAttribute("auth").toString();
            if (auth == null || auth.equals("nothing")) {
                request.getRequestDispatcher("../../index.jsp").forward(request, response);
            }
        %>

        <div class="wrapper">
            <header class="main-header">
                <a href="/DashboardController?type=1&nip=${nip}&name=${name}" class="logo">
                    <span class="logo-mini"><b>M</b>Apps</span>
                    <span class="logo-lg"><b>Monitoring</b>Apps</span>
                </a>

                <nav class="navbar navbar-static-top">
                    <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                        <span class="sr-only">Toggle navigation</span>
                    </a>

                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">
                            <li class="dropdown user user-menu">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <span class="hidden-xs"><%= request.getAttribute("name") %></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <!-- Menu Footer-->
                                    <li class="user-footer">
                                        <div class="pull-right">
                                            <form action="/LogoutController" method="get">
                                                <input type="submit" class="btn btn-default btn-flat" value="Sign out">
                                            </form>
                                        </div>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>
            <aside class="main-sidebar">
                <section class="sidebar">
                    <br>
                    <br>
                    <!--MENU SLIDER-->
                    <ul class="sidebar-menu" data-widget="tree">
                        <li class="header">MAIN MENU</li>
                        <li><a href="/DashboardController?type=2&nip=${nip}&name=${name}"><i class="pull-right-container"></i> List Sales </a></li>
                    </ul>


                </section>
            </aside>

            <div class="content-wrapper">
                <section class="content">


                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="info-box">
                            <span class="info-box-icon bg-yellow"><i class="ion ion-ios-people-outline"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Total Data</span>
                                <span class="info-box-number">110</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="info-box">
                            <span class="info-box-icon bg-aqua"><i class="ion ion-android-calendar"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Schedule</span>
                                <span class="info-box-number">06:00 in | 18:00 out</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="info-box">
                            <span class="info-box-icon bg-yellow"><i class="ion ion-ios-people-outline"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">On time Absense</span>
                                <span class="info-box-number">100</span>
                                <!--<body onload="startTime()">-->
                                <span id="startTime"></span>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="info-box">
                            <span class="info-box-icon bg-yellow"><i class="ion ion-ios-people-outline"></i></span>
                            <div class="info-box-content">
                                <span class="info-box-text">Late Absense</span>
                                <span class="info-box-number">10</span>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

            <aside class="control-sidebar control-sidebar-dark">
                <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
                    <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
                    <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
                </ul>

            </aside>
            <div class="control-sidebar-bg"></div>
        </div>



        <script src="../../bower_components/jquery/dist/jquery.min.js"></script>
        <script src="../../bower_components/jquery-ui/jquery-ui.min.js"></script>
        <script>
            $.widget.bridge('uibutton', $.ui.button);
        </script>
        <script src="../../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="../../bower_components/raphael/raphael.min.js"></script>
        <script src="../../bower_components/morris.js/morris.min.js"></script>
        <script src="../../bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
        <script src="../../plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
        <script src="../../plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
        <script src="../../bower_components/jquery-knob/dist/jquery.knob.min.js"></script>
        <script src="../../bower_components/moment/min/moment.min.js"></script>
        <script src="../../bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
        <script src="../../bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
        <script src="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
        <script src="../../bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
        <script src="../../bower_components/fastclick/lib/fastclick.js"></script>
        <script src="../../dist/js/adminlte.min.js"></script>
        <script src="../../dist/js/pages/dashboard.js"></script>
        <script src="../../dist/js/demo.js"></script>
    </body>
</html>
