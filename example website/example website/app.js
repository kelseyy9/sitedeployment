var img = new Array("ravioli.jpg", "car ravi.jpg", "sun car.jpg", "sausage cat.jpg", "dark ravi.jpg");

var imgElement = document.getElementById("imgDemo");
var i = 0;
var imgLen = img.length;

function nxt()
{
    if(i < imgLen-1)
    {
        i++;
    }else
    {
        i=0;
    }
    imgElement.src = img[i];
}
function prvs()
{
    if(i > 0)
    {
        i--;
    }else
    {
        i = imgLen-1;
    }
    imgElement.src = img[i];
}