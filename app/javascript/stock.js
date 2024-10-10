function searchStocks() {
  var searchValue = document.getElementById("search").value;
  window.location.href = "/stocks/prices?stock=" + searchValue;
}