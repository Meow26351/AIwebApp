var xValues =  ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var users = [];

var colors = ["red", "green","blue","orange","brown"];

var index = 0;
for (const email in gon.chart2_values) {
    users.push({
        name: email,
        data: gon.chart2_values[email],
        color: colors[index]
    });
    index++;
}

new Chart("Chart2", {
    type: "line",
    data: {
        labels: xValues,
        datasets: users.map(function(user) {
            return {
                data: user.data,
                borderColor: user.color,
                fill: false,
                label: user.name
            };
        })
    },
    options: {
        legend: {display: true},
        title: {
            display: true,
            text: "Amount of tasks every agent has done every month"
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