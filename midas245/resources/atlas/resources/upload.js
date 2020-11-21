
var userDataPoints = [];

function showUploadUserData(){

    var manualUploader = new qq.FineUploader({
        element: document.getElementById('fine-uploader-manual-trigger'),
        template: 'qq-template-manual-trigger',
        request: {
            endpoint: '/uploads/userdata'
        },
        thumbnails: {
            placeholders: {
                waitingPath: '/resources/fine-uploader/placeholders/waiting-generic.png',
                notAvailablePath: '/resources/fine-uploader/placeholders/not_available-generic.png'
            }
        },
        validation: {
            //allowedExtensions: ['csv', 'kmz', 'kml', 'zip','txt','json'],
            allowedExtensions: ['csv', 'txt', 'kml', 'kmz'],
            itemLimit: 3,
            sizeLimit: 15000000 // 15mb            
        },  
        messages: {
            typeError: "{file} possui extensão inválida. Extensões válidas: {extensions}.",
            sizeError: "{file} é muito grande, o tamanho máximo é {sizeLimit}.",
            minSizeError: "{file} é muito pequeno, o tamanho mínimo é {minSizeLimit}.",
            emptyError: "{file} está vazio, remova-o da lista.",
            noFilesError: "Sem arquivos para enviar.",
            tooManyItemsError: "Arquivos demais ({netItems}) para enviar.  O limite é {itemLimit}.",
            //maxHeightImageError: "Image is too tall.",
            //maxWidthImageError: "Image is too wide.",
            //minHeightImageError: "Image is not tall enough.",
            //minWidthImageError: "Image is not wide enough.",
            //retryFailTooManyItems: "Retry failed - you have reached your file limit.",
            onLeave: "Envio em andamento, se você sair agora tudo será cancelado.",
            unsupportedBrowserIos8Safari: "Troque de navegador. Este não permite o envio de arquivos como eu preciso."
        },     
        text: {
            defaultResponseError: "Falha de upload por razões desconhecidas",
            fileInputTitle: "arquivo",
            sizeSymbols: [ "kB", "MB", "GB", "TB", "PB", "EB" ]
        },        
        callbacks: {
            
            onComplete: function(id, name, responseJSON, maybeXhr) {
                loadUserDataResult( responseJSON, name );
            },

        /*    
            onSubmit: function(id, name) {},
            onSubmitted: function(id, name) {},
            onComplete: function(id, name, responseJSON, maybeXhr) {},
            onAllComplete: function(successful, failed) {},
            onCancel: function(id, name) {},
            onUpload: function(id, name) {},
            onUploadChunk: function(id, name, chunkData) {},
            onUploadChunkSuccess: function(id, chunkData, responseJSON, xhr) {},
            onResume: function(id, fileName, chunkData, customResumeData) {},
            onProgress: function(id, name, loaded, total) {},
            onTotalProgress: function(loaded, total) {},
            onError: function(id, name, reason, maybeXhrOrXdr) {},
            onAutoRetry: function(id, name, attemptNumber) {},
            onManualRetry: function(id, name) {},
            onValidateBatch: function(fileOrBlobData) {},
            onValidate: function(fileOrBlobData) {},
            onSubmitDelete: function(id) {},
            onDelete: function(id) {},
            onDeleteComplete: function(id, xhrOrXdr, isError) {},
            onPasteReceived: function(blob) {},
            onStatusChange: function(id, oldStatus, newStatus) {},
            onSessionRequestComplete: function(response, success, xhrOrXdr) {}
        */    
        },
        
        autoUpload: false,
        debug: true
    });

    qq(document.getElementById("trigger-upload")).attach("click", function() {
        manualUploader.uploadStoredFiles();
    });    


    $('#uploadUserDataModal').attr('class', 'modal fade bs-example-modal-lg').attr('aria-labelledby','catalogModalLabel');
    $('#uploadUserDataModal').modal('show');
    $("#uploadUserDataModal").on("hidden.bs.modal", function () {
       console.log('Janela fechou');
       $("#fine-uploader-manual-trigger").empty();
    });	
}


function loadFeaturesFromCsv( featureCollection ){
    var promise = Cesium.GeoJsonDataSource.load( featureCollection );
    promise.then( function( dataSource ) {
        var entities = dataSource.entities.values;
        var userDataPackage = {};
        userDataPackage.uuid = createUUID();
        userDataPackage.fileName = fileName;
        userDataPackage.entities = [];
        if( (entities != null) && ( entities.length > 0 ) ){
            for (var i = 0; i < entities.length; i++) {
                var entity = entities[i];
                var nome = entity.properties['texto'];

                var userPoint = viewer.entities.add({
                    name : 'IMPORT_USER_POINT',
                    position : entity.position,
                    billboard :{
                        image : '/resources/img/pin-start.png',
                        pixelOffset : new Cesium.Cartesian2(0, -10),
                        scaleByDistance : new Cesium.NearFarScalar(1.5e2, 0.6, 1.5e7, 0.2),
                        eyeOffset : new Cesium.Cartesian3(0.0, 0.0, 0.0),
                        horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
                        verticalOrigin : Cesium.VerticalOrigin.CENTER,
                        disableDepthTestDistance : Number.POSITIVE_INFINITY     
                    },
                    label : {
                        text : nome,
                        fillColor : Cesium.Color.BLACK,
                        font: '10px Consolas',
                        horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
                        eyeOffset : new Cesium.Cartesian3(0.0, 800.0, 0.0),
                        pixelOffsetScaleByDistance : new Cesium.NearFarScalar(1.5e2, 1.4, 1.5e7, 0.7),
                        disableDepthTestDistance : Number.POSITIVE_INFINITY,
                    }

                });	

                userDataPackage.entities.push( userPoint );

            }            
        } 
        
        userDataPoints.push( userDataPackage );
        addUserDataCard( userDataPackage );
    });    

    fireToast( 'info', 'Sucesso', 'Dados carregados com sucesso.', '404' );

}

function loadUserDataResult( responseJSON, fileName ){
    $('#uploadUserDataModal').modal('hide');
    $('#uploadUserDataModal').modal('dispose');
    $('#fine-uploader-manual-trigger').empty();

    console.log( responseJSON );

    var jsonObj = JSON.parse( responseJSON.content );
    
    if( jsonObj.features ){
        loadFeaturesFromCsv( jsonObj );
        return;        
    } 

    if( jsonObj.filePath ){
        
        var dataSourcePromise = viewer.dataSources.add(Cesium.KmlDataSource.load( jsonObj.filePath , options));
        dataSourcePromise.then(function(dataSource){
            var rider = dataSource.entities.getById('CSDL');//在kml中必须有此id
            viewer.flyTo(rider);
        }).otherwise(function(error){
            window.alert(error);
        });
    

    }

    fireToast( 'error', 'Erro', 'Não foi possível carregar os dados do arquivo.', '404' );

}



