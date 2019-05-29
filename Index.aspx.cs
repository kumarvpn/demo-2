using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using FusionCharts;

public partial class Index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FetchData data = new FetchData();
        List<Orders> fetchedOrder = new List<Orders>();
        fetchedOrder = data.getOrders();

        List<Country> countryList = new List<Country>();

        countryList = fetchedOrder.GroupBy(l => l.Country).Select(cl => new Country
        {
            CountryName = cl.First().Country,
            Percentage = cl.Sum(c => c.Percentage)

        }).ToList();


        StringBuilder dataSource = new StringBuilder();
        string str = "";
        dataSource.Append("{'chart': {'theme': 'fusion', 'caption': 'Order percentage based on countries', 'pieRadius':'180', 'numbersuffix':'%', 'enableMultiSlicing': '0', 'paletteColors': '#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000', 'bgColor': '#ffffff', 'showBorder': '0', 'use3DLighting': '1', 'showShadow': '0', 'enableSmartLabels': '1', 'startingAngle': '310', 'showLabels': '0', 'showPercentValues': '1', 'showLegend': '0', 'captionFontSize': '14',  'toolTipColor': '#ffffff', 'toolTipBorderThickness': '0', 'toolTipBgColor': '#000000', 'toolTipBgAlpha': '80', 'toolTipBorderRadius': '2', 'toolTipPadding': '5', },'data': [");

        foreach (Country newCountry in countryList)
        {
            //Response.Write(newCountry.CountryName + "</br>" + newCountry.Percentage + "</br>");
            str += "{'label': '" + newCountry.CountryName.Trim() + "' , 'value':'" + newCountry.Percentage + "' },";

        }
        dataSource.Append(str);
        dataSource.Append("] }");

        FusionCharts.Charts.Chart newChart = new FusionCharts.Charts.Chart("doughnut3d", "myChart", "500", "500", "json", dataSource.ToString());
        newChart.AddEvent("dataplotclick", "clickHandler");
        lit.Text = newChart.Render();




    }
}
