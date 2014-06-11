function getBookMarks(){
    chrome.bookmarks.getTree(
        function(bookmarkTreeNodes) {
            console.log(bookmarkTreeNodes);
        });
}
function show(id, bookmarks){
    console.log(id);
    console.log(bookmarks);
}


function post(url, data){
    var method = "POST";
    var postData = "Some data";
    
    // You REALLY want async = true.
    // Otherwise, it'll block ALL execution waiting for server response.
    var async = true;
    
    var request = new XMLHttpRequest();
    
    request.open(method, url, async);
    
    request.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    // Or... request.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
    // Or... whatever
    
    // Actually sends the request to the server.
    request.send(data);
}

function add(id, bookmarks){
    console.log(bookmarks)
    post("http://0.0.0.0:3000/add", JSON.stringify(bookmarks));
}
function remove(id, bookmarks){
    post("http://0.0.0.0:3000/remove", JSON.stringify(bookmarks));
}
function update(id, bookmarks){
    post("http://0.0.0.0:3000/update", JSON.stringify(bookmarks));
}
chrome.bookmarks.onRemoved.addListener(remove);
chrome.bookmarks.onCreated.addListener(add);
//只有title和url改变时会触发
///chrome.bookmarks.onChanged.addListener(update);
//chrome.bookmarks.onMoved.addListener(update);
