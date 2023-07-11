// let mostrando = 0;
// $('.lista').click(()=>{
//     if(mostrando == 0){
//         mostrando = 1;
//         $(this).addClass('activeItem');
//         $('#cores').slideDown(200);
//     }else{
//         mostrando = 0;
//         $('#cores').slideUp(200);

//     }
// })


let roupaID = null;
let dataPart = null;
let sexoLoja = 'Male';
let dataCat = 'mascara';
let change = {}
let oldPart = {}
let ultLoja = null;
let lojaDados = null;
let aberto2 = false;
let colorOpen = true;

let sizeW = 100;
let sizeH = 100;

$(document).ready(function() {
    document.onkeydown = function(data) {
        if (data.keyCode == 27) {
            $('#listagem').html('');
            $("#container").fadeOut();
            $('#totalDireita').html('0'); 
            change = {};
            $.post('http://nyo_lojaderoupas/reset', JSON.stringify({}))
            $('#cores').slideUp(200);
        }
    }

    $("#esquerda").click(function() {
        $.post('http://nyo_lojaderoupas/leftHeading', JSON.stringify({ value: 10 }));
    })

    $("#maos").click(function() {
        $.post('http://nyo_lojaderoupas/handsUp', JSON.stringify({}));
    })

    $("#direita").click(function() {
        $.post('http://nyo_lojaderoupas/rightHeading', JSON.stringify({ value: 10 }));
    })

    $("#cart").click(function() {
        $("#container").fadeOut()
        $.post('http://nyo_lojaderoupas/payament', JSON.stringify({ price: $('#totalDireita').text(), parts: oldPart }));
        $('#totalDireita').html('0');
        change = {};
        $('#cores').slideUp(200);
    })

    window.addEventListener('message', function(event) {
        let item = event.data;

        if (item.action == 'setPrice') {
            if (item.typeaction == "add") {
                $('#totalDireita').html(item.price)
            }
            if (item.typeaction == "remove") {
                $('#totalDireita').html(item.price)
            }
        }
        
        if (item.openLojaRoupa) {
            oldPart = item.oldCustom
            change = {};
            ultLoja = item.ultLoja;
            lojaDados = item.dadosLoja;
            $("#container").fadeIn()
            dataPart = item.category
            $('#listagem').html('')
            if(item.category == 'p2' || item.category == 'p6'|| item.category == 'p7'){                    
                $("#listagem").append(`
                    <div class="lista" data-id="-1" onclick="select(this)" id="${item.category}-1" style="background-image: url('http://189.127.164.126/roupas/${item.category}/${item.sexo}/${i}_0.png');">
                        <div class="valorItem">R$${lojaDados[ultLoja-1]['clouth'][dataPart]['price']} </div>
                        <div class="tresD" onclick="open3D(9999,9999,0)">3D</div>
                        <div class="idItem">RETIRAR</div>
                    </div>
                `);
            }

            for (var i = 0; i <= (item.drawa -1); i++) {   
                var exibeItem = false;
                if(lojaDados[ultLoja-1]['type'] == 'all'){
                    exibeItem = true;
                }else if(lojaDados[ultLoja-1]['type'] == 'exclusive'){
                    if(inArray(i, lojaDados[ultLoja-1]['clouth'][dataPart]['clouth'])){
                        exibeItem = true;
                    }
                }else if(lojaDados[ultLoja-1]['type'] == 'exclude'){
                    if(!inArray(i, lojaDados[ultLoja-1]['clouth'][dataPart]['clouth'])){
                        exibeItem = true;
                    }
                }

               

                
                if(exibeItem){
                    $("#listagem").append(`
                    <div class="lista" data-id="${i}" onclick="select(this)" id="${item.category}${i}" style="background-image: url('http://189.127.164.126/roupas/${item.category}/${item.sexo}/${i}_0.png'); background-size: ${sizeW}px; ${sizeH}px;">
                        <div class="valorItem">R$${lojaDados[ultLoja-1]['clouth'][dataPart]['price']} </div>
                        <div class="tresD" onclick="open3D(${item.category},${i},0)">3D</div>
                        <div class="idItem">${i}</div>
                    </div>
                    `);
                    if (oldPart[item.category][0] == i) {
                        select2(i);
                    }  
                }  
            };
            $('#cores').slideDown(200);
           
        }
        if (item.changeCategory) {
            sexoLoja = item.sexo;
            dataPart = item.category;
            $('#listagem').html('');
            if(item.category == 'p2' || item.category == 'p6'|| item.category == 'p7'){                                  
                $("#listagem").append(`
                    <div class="lista" data-id="-1" onclick="select(this)" id="${item.category}-1" style="background-image: url('http://189.127.164.126/roupas/${item.category}/${item.sexo}/${i}_0.png'); background-size: ${sizeW}px; ${sizeH}px;">
                        <div class="valorItem">R$${lojaDados[ultLoja-1]['clouth'][dataPart]['price']} </div>
                        <div class="tresD" onclick="open3D(9999,9999,0)">3D</div>
                        <div class="idItem">RETIRAR</div>
                    </div>
                `);
            }
            for (var i = 0; i <= (item.drawa -1); i++) {     
                var exibeItem = false;
                if(lojaDados[ultLoja-1]['type'] == 'all'){
                    exibeItem = true;
                }else if(lojaDados[ultLoja-1]['type'] == 'exclusive'){
                    if(inArray(i, lojaDados[ultLoja-1]['clouth'][dataPart]['clouth'])){
                        exibeItem = true;
                    }
                }else if(lojaDados[ultLoja-1]['type'] == 'exclude'){
                    if(!inArray(i, lojaDados[ultLoja-1]['clouth'][dataPart]['clouth'])){
                        exibeItem = true;
                    }
                }


                
                
                if(exibeItem){
                    $("#listagem").append(`
                    <div class="lista" data-id="${i}" onclick="select(this)" id="${item.category}${i}" style="background-image: url('http://189.127.164.126/roupas/${item.category}/${item.sexo}/${i}_0.png'); background-size: ${sizeW}px; ${sizeH}px;">
                        <div class="valorItem">R$${lojaDados[ultLoja-1]['clouth'][dataPart]['price']} </div>
                        <div class="tresD" onclick="open3D(${item.category},${i},0)">3D</div>
                        <div class="idItem">${i}</div>
                    </div>
                    `);
                    if (oldPart[item.category][0] == i) {
                        select2(i);
                    }  
                }  

            };            
        }

        if(item.changeCategoryColor) {
            //dataPart = item.category;
            $('#listaCores').html('')   
            let itemMax = item.max - 1;      
            for (var i = 0; i <= itemMax; i++) {             
                $("#listaCores").append(`
                    <div class="listaCor" id="color${i}" onclick="selectColor(this, ${i})" style="background-image: url('http://189.127.164.126/roupas/${item.category}/${item.sexo}/${roupaID}_${i}.png'); background-size: 100px; 100px;">
                        <div class="valorItem">R$0</div>
                        <div class="tresD" onclick="open3D(${item.category},${roupaID},${i})">3D</div>
                        <div class="idItem">${i}</div>
                    </div>
                `);
                if (oldPart[item.category][1] == i) {
                    selectColor2(i);
                }
            };      
        }

        if(item.atualizaRoupa) { 
            oldPart[dataPart][1] = item.color;
        }
    })
});

function inArray(needle, haystack) {
    var length = haystack.length;
    for(var i = 0; i < length; i++) {
        if(haystack[i] == needle) return true;
    }
    return false;
}

function update_valor() {
    const formatter = new Intl.NumberFormat('pt-BR', { minimumFractionDigits: 2 })
    let total = 0
    for (let key in change) { if (!change[key] == 0) { total += 40 } }
    $('#totalDireita').html(formatter.format(total))
}


function selectPart(element) {    
    let dataPart = element.dataset.idpart;
    dataCat = dataPart;
    $('header h1').html(dataPart);
    $('.menuType').find('img').css('filter', 'brightness(100%)');
    $('.menuType').removeClass('ativada');
    $('#listaCores').html('');
    $(element).addClass('ativada');    
    $.post('http://nyo_lojaderoupas/changePart', JSON.stringify({ part: dataPart }));
}

function select(element) {
    roupaID = element.dataset.id;
    $('.lista').removeClass('activeLista');
    $(element).addClass('activeLista'); 
    oldPart[dataPart][0] = roupaID;
    oldPart[dataPart][1] = 0;
    $('#showtresD').html(`<model-viewer src="http://189.127.164.126/roupas/${dataPart}/${sexoLoja}/3d/${roupaID}_0.glb" alt="" environment-image="neutral" id="modelColor" auto-rotate camera-controls></model-viewer>`);
    $.post('http://nyo_lojaderoupas/changeCustom', JSON.stringify({ type: dataPart, id: roupaID, color: 0 }));    
    $.post('http://nyo_lojaderoupas/updateColor', JSON.stringify({ part: dataCat }));
}

function select2(id) {
    roupaID = id;
    $('.lista').removeClass('activeLista');
    $(`#${dataPart}${id}`).addClass('activeLista'); 
    oldPart[dataPart][0] = roupaID;   
    $('#showtresD').html(`<model-viewer src="http://189.127.164.126/roupas/${dataPart}/${sexoLoja}/3d/${roupaID}_${oldPart[dataPart][1]}.glb" alt="" environment-image="neutral" id="modelColor" auto-rotate camera-controls></model-viewer>`);
    $.post('http://nyo_lojaderoupas/changeCustom', JSON.stringify({ type: dataPart, id: roupaID, color: oldPart[dataPart][1] }));
    $.post('http://nyo_lojaderoupas/updateColor', JSON.stringify({ part: dataCat }));
}

function selectColor(element, id){    
    $('.listaCor').removeClass('activeLista');
    $(element).addClass('activeLista'); 
    $('#showtresD').html(`<model-viewer src="http://189.127.164.126/roupas/${dataPart}/${sexoLoja}/3d/${roupaID}_${id}.glb" alt="" environment-image="neutral" id="modelColor" auto-rotate camera-controls></model-viewer>`);
    $.post('http://nyo_lojaderoupas/changeCustom', JSON.stringify({ type: dataPart, id: roupaID, color: id }));
}

function selectColor2(id){    
    $('.listaCor').removeClass('activeLista');
    $('#color'+id).addClass('activeLista'); 
}

function open3D(category, item, color){
   if(aberto2){
    aberto2 = false;
    $('#showtresD').slideUp(500);
   }else{
    aberto2 = true;
    $('#showtresD').html(`<model-viewer src="http://189.127.164.126/roupas/${category}/${sexoLoja}/3d/${item}_${color}.glb" alt="" environment-image="neutral" id="modelColor" auto-rotate camera-controls></model-viewer>`);
    $('#showtresD').slideDown(500);
   }
}

$(".fa-angle-right").click(function() {
    $.post('http://nyo_lojaderoupas/changeColor', JSON.stringify({ type: dataPart, id: roupaID, action: "mais" }));
})

$(".fa-angle-left").click(function() {
    $.post('http://nyo_lojaderoupas/changeColor', JSON.stringify({ type: dataPart, id: roupaID, action: "menos" }));
})

$("#colorChange").click(function() {
    if(colorOpen){
        colorOpen = false;
        $('#cores').slideUp(500);
    }else{
        colorOpen = true;
        $('#cores').slideDown(500);
    }
})


