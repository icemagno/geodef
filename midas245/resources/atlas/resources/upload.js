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
            allowedExtensions: ['csv', 'kmz', 'kml', 'zip','txt','json'],
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
                console.log( id );
                console.log( name );
                console.log( JSON.parse( responseJSON.content ) );
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
