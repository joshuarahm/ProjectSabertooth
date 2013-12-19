_timer_set = 0
function resetTimer() {
    //_should_save = 1;
    _timer_set = 0
    console.log("Updated!" + Math.random());
    writeDocChange()
}
function writeDocChange() {
    editUrl = "/document/%ID/edit"
    id = $("#document_id").html().toString().trim()
    contents = $("#main_document")[0].value
    title = $("#document_title")[0].value
    
    $("#doc_badge").text("Saved")
    console.log("Found doc_id = '" + id + "'")
    editUrl = editUrl.replace("%ID", id)
    $.post(editUrl, {id: id, contents: contents.toString(), title: title.toString()})
}
    
function textUpdateListener() {
    $("#doc_badge").text("Edited")
    if (_timer_set) {
        return;
    } else {
        setTimeout(resetTimer, 1000)
        _timer_set = 1
    }
}

function docLoad() {
    //You have to send these with every POST or rails will freak out
    $.ajaxSetup({
          headers: {
              'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            }
    });
    //Redirect causes event listeners to clear,
    //but does NOT trigger onLoad again.
    //It does not clear setInterval though, so this workaround still works.
    inp = $("#main_document")[0]
    inp.addEventListener("input",textUpdateListener, false)
    inp = $("#document_title")[0]
    inp.addEventListener("input",textUpdateListener, false)
}
