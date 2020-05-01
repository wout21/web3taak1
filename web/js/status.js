let xhr = new XMLHttpRequest();
let timeout;

function changeStatus() {
    xhr.open("POST","Controller?action=SetStatus&status="+document.getElementById("input").value,true);
    xhr.onreadystatechange = setStatus;
    xhr.send(null);
}


function setStatus() {
    if(xhr.status === 200){
        if(xhr.readyState === 4){
            let returnedStatus = JSON.parse(xhr.responseText);
            let status = returnedStatus.status;
            let p = document.getElementById("status");
            p.innerHTML = "";
            let text = document.createTextNode(status);
            p.appendChild(text);
        }
    }
}

getFriendlist();
function getFriendlist() {
    xhr.open("GET","Controller?action=UpdateFriends");
    xhr.onreadystatechange = showFriends;
    xhr.send(null);
}

function showFriends() {
    if(xhr.status === 200){
        if(xhr.readyState){

            $('#friendlist').html("");

            let jsonFriendlist = JSON.parse(xhr.responseText);
            let table = document.getElementById("friendlist");

            for(let person in jsonFriendlist){
                let tr = document.createElement("tr");
                let friendName = document.createElement("td");
                let status = document.createElement("td");

                friendName.innerText = jsonFriendlist[person].name;
                status.innerText = jsonFriendlist[person].status;

                tr.appendChild(friendName);
                tr.appendChild(status);

                table.appendChild(tr);
            }
            timeout = setTimeout(getFriendlist,3000);
        }
    }
}

function checkIfReaddy(){
    console.log(xhr.readyState);
    if(xhr.readyState === 4){
        getFriendlist();
    }
}


function addFriend() {
    clearTimeout(timeout);
    url = "Controller?action=AddFriend&name=" + $("#addFriendInput").val();
    xhr.open("POST", url);
    xhr.onreadystatechange = checkIfReaddy;
    xhr.send(null);
}
