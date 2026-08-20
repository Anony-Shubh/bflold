const ctx = document.getElementById("myChart");
const applications = document.getElementById("applications");

new Chart(ctx, {
  type: "pie",
  data: {
    labels: ["General", "Minority", "OBC", "SC", "ST"],
    datasets: [
      {
        label: "Percentage count",
        data: [35.3, 9, 32, 15.7, 7.9],
        backgroundColor: [
          "rgba(54, 162, 235, 1)",
          "rgba(255, 99, 132, 1)",
          "rgba(255, 159, 64, 1)",
          "rgba(255, 205, 86, 1)",
          "rgba(75, 192, 192, 1)",
        ],
      },
    ],
  },
  options: {
    responsive: true,
  },
});

new Chart(applications, {
  type: "bar",
  data: {
    labels: [
      "28-Mar",
      "29-Mar",
      "30-Mar",
      "31-Mar",
      "01-Apr",
      "02-Apr",
      "03-Apr",
      "04-Apr",
      "05-Apr",
      "06-Apr",
    ],
    datasets: [
      {
        label: "Percentage count",
        data: [1056, 1004, 691, 803, 609, 258, 966, 640, 1124, 595],
        backgroundColor: [
          "rgba(54, 162, 235, 1)",
          "rgba(255, 99, 132, 1)",
          "rgba(255, 159, 64, 1)",
          "rgba(255, 205, 86, 1)",
          "rgba(75, 192, 192, 1)",
        ],
      },
    ],
  },
  options: {
    scales: {
      y: {
        beginAtZero: true,
      },
    },
  },
});
