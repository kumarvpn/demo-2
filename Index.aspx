<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>  
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> 
    <script src="https://cdn.fusioncharts.com/fusioncharts/latest/fusioncharts.js"></script>
    <script src="https://cdn.fusioncharts.com/fusioncharts/latest/themes/fusioncharts.theme.fusion.js"></script>
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
  <!-- Navbar content -->
       <a class="navbar-brand" href="#">  FusionCharts POC for showcasing Orders data visualization with Doughnut 3d chart.</a>
</nav>
    <form id="form1" runat="server">
    <script type="text/javascript">  
        var tableDataSource = null;
        $(document).ready(function () {
           
            $.ajax({  
                url: '/FetchData.asmx/getAllOrders',  
                dataType: "json",  
                method: 'post',  
                success: function (data) {  
                   var employeeTable = $('#tblEmployee tbody');  
                   employeeTable.empty();
                   tableDataSource = data;
                    $(data).each(function (index, emp) {  
                        employeeTable.append('<tr><td>' + emp.City + '</td><td>'  
                            + emp.Percentage + '</td><td>' + emp.Country + '</td>');  
                    });  
                  
                },  
                error: function (err) {  
                    alert(err);  
                }  
            });
          
        });
        clickHandler = function (e) {
            var employeeTable = $('#tblEmployee tbody');
            employeeTable.empty();
            var country = e.sender.args.dataSource.data[e.data.dataIndex].label;
           /* var refined = [];
            tableDataSource.forEach(function (element) {
                console.log(element.Country.trim().length + element.Country);
                if (element.Country === country)
                    refined.push(element);

            });
            console.log(refined);*/
            $(tableDataSource).each(function (index, emp) {
                if (emp.Country.trim() === country)
                employeeTable.append('<tr><td>' + emp.City + '</td><td>'
                    + emp.Percentage + '</td><td>' + emp.Country + '</td>');
            });

        };
    </script>  


        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>

    <div class="container">  
        <div class="row">
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
       <asp:Literal ID="lit" runat="server"></asp:Literal>
      </div>
    </div>
  </div>
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
         <table id="tblEmployee" class="table table-sm">  
                <thead class="bg-primary text-white">  
                    <tr>  
                        <th scope="col">City</th>  
                        <th  scope="col">Percentage</th>  
                        <th  scope="col">Country</th>  
                    </tr>  
                </thead>  
                <tbody></tbody>  
            </table>  
      </div>
    </div>
  </div>
</div>
           
           
        </div> 
    </form>
</body>
</html>