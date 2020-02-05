<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%--
  Created by IntelliJ IDEA.
  User: AKBAR
  Date: 26/01/2020
  Time: 23.49
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
    <link rel="stylesheet" href="../../bower_components/bootstrap-daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="../../bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="../../plugins/iCheck/all.css">
    <link rel="stylesheet" href="../../bower_components/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css">
    <link rel="stylesheet" href="../../plugins/timepicker/bootstrap-timepicker.min.css">
    <link rel="stylesheet" href="../../bower_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="../../dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="../../dist/css/skins/_all-skins.min.css">
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <script src="angular.min.js"></script>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
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
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>

                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="hidden-xs"><%= request.getAttribute("name") %></span>
                            </a>
                            <ul class="dropdown-menu">
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
        </aside>

        <div class="content-wrapper">
            <section class="content-header">
                <div>
                    <h1>
                        List Acquisition
                    </h1>
                    <a href="javascript:history.back()">Back to List</a>
                </div>
            </section>
            <section class="content">
                <div ng-controller="listController">
                    <!--<title>Marker Satu Lokasi</title>-->
                    <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCKV38o3IepDvn1e9Ix4jAHKT29OXD8p3w&sensor=false"></script>
                    <style>
                        #map {
                            width: 100%;
                            height: 500px;
                        }
                    </style>
                    <script type="text/javascript">
                        (function() {
                            window.onload = function() {

                                var options = {
                                    zoom: 7,
                                    center: new google.maps.LatLng(-6.886791,107.615238),
                                    mapTypeId: google.maps.MapTypeId.ROADMAP
                                };

                                var map = new google.maps.Map(document.getElementById('map'), options);
                                var markers = [
                                    <%
                                        String data = request.getAttribute("data").toString();
                                        JSONArray array = new JSONArray(data);
                                        for (int d = 0; d < array.length(); d++) {
                                            JSONObject object = array.getJSONObject(d);
                                            System.out.println("object data : "+object.toString());

                                            int custom = object.getInt("custom");
                                            if (custom == 1) {
                                                %>
                                                {
                                                    coords:{lat:<%= object.getDouble("latitude")%>,lng:<%= object.getDouble("longitude")%>},
                                                    iconImage: '../../dist/img/attendance_icon.png',
                                                    content:'<h1>Lokasi Absen</h1>'
                                                },
                                                <%
                                            } else if (custom == 2) {
                                                 %>
                                                {
                                                    coords:{lat:<%= object.getDouble("latitude")%>,lng:<%= object.getDouble("longitude")%>},
                                                    iconImage: '../../dist/img/break_in_icon.png',
                                                    content:'<h1>Lokasi Istirahat</h1>'
                                                },
                                                <%
                                            } else if (custom == 3) {
                                                 %>
                                                {
                                                    coords:{lat:<%= object.getDouble("latitude")%>,lng:<%= object.getDouble("longitude")%>},
                                                    iconImage: '../../dist/img/break_out_icon.png',
                                                    content:'<h1>Lokasi Selesai Istirahat</h1>'
                                                },
                                                <%
                                            } else if (custom == 4) {
                                                 %>
                                                {
                                                    coords:{lat:<%= object.getDouble("latitude")%>,lng:<%= object.getDouble("longitude")%>},
                                                    iconImage: '../../dist/img/end_attendance_icon.png',
                                                    content:'<h1>Lokasi Pulang</h1>'
                                                },
                                                <%
                                            } else {
                                                 %>
                                                {
                                                    coords:{lat:<%= object.getDouble("latitude")%>,lng:<%= object.getDouble("longitude")%>},
                                                    iconImage: '../../dist/img/track_icon.png',
                                                    content:'<h1>Lokasi Tracking</h1>'
                                                },
                                                <%
                                            }
                                        }
                                    %>
                                ];

                                for(var i = 0;i < markers.length;i++){
                                    addMarker(markers[i]);
                                }

                                function addMarker(props){
                                    var marker = new google.maps.Marker({
                                        position:props.coords,
                                        map:map,
                                        //icon:props.iconImage
                                    });

                                    // Check for customicon
                                    if(props.iconImage){
                                        // Set icon image
                                        marker.setIcon(props.iconImage);
                                    }

                                    // Check content
                                    if(props.content){
                                        var infoWindow = new google.maps.InfoWindow({
                                            content:props.content
                                        });

                                        marker.addListener('click', function(){
                                            infoWindow.open(map, marker);
                                        });
                                    }
                                }
                            };
                        })();
                    </script>
                    <center>
                        <!--<h4>Meletakkan Marker di Google Maps</h4>-->
                        <div id="map"></div>

                    </center>
                </div>
            </section>
        </div>
        <div class="control-sidebar-bg"></div>
    </div>

    <script src="../../bower_components/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.3.7 -->
    <script src="../../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="../../bower_components/select2/dist/js/select2.full.min.js"></script>
    <script src="../../plugins/input-mask/jquery.inputmask.js"></script>
    <script src="../../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="../../plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <script src="../../bower_components/moment/min/moment.min.js"></script>
    <script src="../../bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script src="../../bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    <script src="../../bower_components/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
    <script src="../../plugins/timepicker/bootstrap-timepicker.min.js"></script>
    <script src="../../bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <script src="../../plugins/iCheck/icheck.min.js"></script>
    <script src="../../bower_components/fastclick/lib/fastclick.js"></script>
    <script src="../../dist/js/adminlte.min.js"></script>
    <script src="../../dist/js/demo.js"></script>
    <script>
        $(function () {
            //Initialize Select2 Elements
            $('.select2').select2()

            //Datemask dd/mm/yyyy
            $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
            //Datemask2 mm/dd/yyyy
            $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
            //Money Euro
            $('[data-mask]').inputmask()

            //Date range picker
            $('#reservation').daterangepicker()
            //Date range picker with time picker
            $('#reservationtime').daterangepicker({ timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A' })
            //Date range as a button
            $('#daterange-btn').daterangepicker(
                {
                    ranges   : {
                        'Today'       : [moment(), moment()],
                        'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                        'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
                        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                        'This Month'  : [moment().startOf('month'), moment().endOf('month')],
                        'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                    },
                    startDate: moment().subtract(29, 'days'),
                    endDate  : moment()
                },
                function (start, end) {
                    $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
                }
            )

            //Date picker
            $('#datepicker').datepicker({
                autoclose: true
            })

            //iCheck for checkbox and radio inputs
            $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
                checkboxClass: 'icheckbox_minimal-blue',
                radioClass   : 'iradio_minimal-blue'
            })
            //Red color scheme for iCheck
            $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
                checkboxClass: 'icheckbox_minimal-red',
                radioClass   : 'iradio_minimal-red'
            })
            //Flat red color scheme for iCheck
            $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass   : 'iradio_flat-green'
            })

            //Colorpicker
            $('.my-colorpicker1').colorpicker()
            //color picker with addon
            $('.my-colorpicker2').colorpicker()

            //Timepicker
            $('.timepicker').timepicker({
                showInputs: false
            })
        })
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
</body>
</html>
