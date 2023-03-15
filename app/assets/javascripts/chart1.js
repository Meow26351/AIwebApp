var xValues = gon.chart1_xvalues;
var yValues = gon.chart1_yvalues
var barColors = ["red", "green","blue","orange","brown"];

new Chart("Chart1", {
    type: "bar",
    data: {
        labels: xValues,
        datasets: [{
            backgroundColor: barColors,
            data: yValues
        }]
    },
    options: {
        legend: {display: false},
        title: {
            display: true,
            text: "Amount of tasks every agent has done"
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true,
                    precision: 0
                }
            }]
        }
    }
});








