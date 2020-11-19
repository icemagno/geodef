<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3 -->
<script src="${midasLocation}/bower_components/jquery/dist/jquery.min.js"></script>

<!-- Bootstrap 3.3.7 -->
<script src="${midasLocation}/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

<!-- PACE -->
<!-- 
<script data-pace-options='{ "document": false }' src="${midasLocation}/bower_components/PACE/pace.min.js"></script>
 -->
 
<!-- SlimScroll -->
<script src="${midasLocation}/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="${midasLocation}/bower_components/fastclick/lib/fastclick.js"></script>

<!-- DataTables -->
<script src="${midasLocation}/datatables/datatables.min.js"></script>

<!-- AdminLTE App -->
<script src="${midasLocation}/dist/js/adminlte.min.js"></script>

<!-- Bootstrap slider -->
<script src="${midasLocation}/plugins/bootstrap-slider/bootstrap-slider.js"></script>

<!-- iCheck -->
<script src="${midasLocation}/plugins/iCheck/icheck.min.js"></script>

<!-- Select2 -->
<script src="${midasLocation}/bower_components/select2/dist/js/select2.full.min.js"></script>



<!-- FLOT CHARTS -->
<script src="${midasLocation}/bower_components/Flot/jquery.flot.js"></script>
<!-- FLOT RESIZE PLUGIN - allows the chart to redraw when the window is resized -->
<script src="${midasLocation}/bower_components/Flot/jquery.flot.resize.js"></script>
<!-- FLOT PIE PLUGIN - also used to draw donut charts -->
<script src="${midasLocation}/bower_components/Flot/jquery.flot.pie.js"></script>
<!-- FLOT CATEGORIES PLUGIN - Used to draw bar charts -->
<script src="${midasLocation}/bower_components/Flot/jquery.flot.categories.js"></script>

<script src="${midasLocation}/sweetalert2.min.js"></script>

<!-- TOAST JQUERY -->
<script type="text/javascript" src="/resources/js/jquery.toast.min.js"></script>

<script src="${midasLocation}/atlas/resources/toast.js"></script>

<!-- Morris.js charts -->
<script src="${midasLocation}/bower_components/raphael/raphael.min.js"></script>
<script src="${midasLocation}/bower_components/morris.js/morris.min.js"></script>


<!-- InputMask -->
<script src="${midasLocation}/plugins/input-mask/jquery.inputmask.js"></script>
<script src="${midasLocation}/plugins/input-mask/jquery.inputmask.extensions.js"></script>
<script src="${midasLocation}/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="${midasLocation}/plugins/input-mask/jquery.inputmask.numeric.extensions.js"></script>
<script src="${midasLocation}/plugins/input-mask/jquery.inputmask.phone.extensions.js"></script>
<script src="${midasLocation}/plugins/input-mask/jquery.inputmask.regex.extensions.js"></script>


<!-- FLIGHT -->
<script type="text/javascript" src="/resources/js/jquery.flightindicators.min.js"></script>

<!-- TREEVIEW -->
<!-- 
<script type="text/javascript" src="/resources/js/bootstrap-treeview.min.js"></script>
 -->
<script src="${midasLocation}/gijgo/js/gijgo.js"></script>
 
 <!-- Bootstrap slider -->
<script src="${midasLocation}/plugins/bootstrap-slider/bootstrap-slider.js"></script>
 

<!-- Particles -->
<script src="/resources/particles/particles.min.js"></script>

<script type="text/javascript" src="/resources/js/jquery.awesome-cursor.min.js"></script>

<script src="${midasLocation}/atlas/resources/sockjs.min.js" type="text/javascript"></script>
<script src="${midasLocation}/atlas/resources/stomp.min.js" type="text/javascript"></script>
<script src="${midasLocation}/atlas/resources/script.js" type="text/javascript"></script>


<script type="text/javascript" src="${midasLocation}/bower_components/jquery-ui/jquery-ui.js"></script>

<script type="text/javascript" src="/resources/fine-uploader/fine-uploader.js"></script>


<script type="text/template" id="qq-template-manual-trigger">
        <div class="qq-uploader-selector qq-uploader" qq-drop-area-text="Solte arquivos aqui">
            <div class="qq-total-progress-bar-container-selector qq-total-progress-bar-container">
                <div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-total-progress-bar-selector qq-progress-bar qq-total-progress-bar"></div>
            </div>
            <div class="qq-upload-drop-area-selector qq-upload-drop-area" qq-hide-dropzone>
                <span class="qq-upload-drop-area-text-selector"></span>
            </div>
            <div class="buttons">
                <div class="qq-upload-button-selector qq-upload-button btn btn-primary" >
                    <div>Selecionar</div>
                </div>
                <button type="button" id="trigger-upload" class="btn btn-primary">
                    <i class="icon-upload icon-white"></i> Enviar
                </button>
            </div>
            <span class="qq-drop-processing-selector qq-drop-processing">
                <span>Processando arquivos...</span>
                <span class="qq-drop-processing-spinner-selector qq-drop-processing-spinner"></span>
            </span>
            <ul class="qq-upload-list-selector qq-upload-list" aria-live="polite" aria-relevant="additions removals">
                <li>
                    <div class="qq-progress-bar-container-selector">
                        <div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-progress-bar-selector qq-progress-bar"></div>
                    </div>
                    <span class="qq-upload-spinner-selector qq-upload-spinner"></span>
                    <img class="qq-thumbnail-selector" qq-max-size="100" qq-server-scale>
                    <span class="qq-upload-file-selector qq-upload-file"></span>
                    <span class="qq-edit-filename-icon-selector qq-edit-filename-icon" aria-label="Edit filename"></span>
                    <input class="qq-edit-filename-selector qq-edit-filename" tabindex="0" type="text">
                    <span class="qq-upload-size-selector qq-upload-size"></span>
                    <button type="button" class="qq-btn qq-upload-cancel-selector qq-upload-cancel">Cancelar</button>
                    <button type="button" class="qq-btn qq-upload-retry-selector qq-upload-retry">Reenviar</button>
                    <button type="button" class="qq-btn qq-upload-delete-selector qq-upload-delete">Apagar</button>
                    <span role="status" class="qq-upload-status-text-selector qq-upload-status-text"></span>
                </li>
            </ul>

            <dialog class="qq-alert-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">Close</button>
                </div>
            </dialog>

            <dialog class="qq-confirm-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">No</button>
                    <button type="button" class="qq-ok-button-selector">Yes</button>
                </div>
            </dialog>

            <dialog class="qq-prompt-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <input type="text">
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">Cancel</button>
                    <button type="button" class="qq-ok-button-selector">Ok</button>
                </div>
            </dialog>
        </div>
    </script>

