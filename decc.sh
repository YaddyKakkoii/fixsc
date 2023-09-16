#!/bin/bash
skip=23
set -C
umask=`umask`
umask 77
tmpfile=`tempfile -p gztmp -d /tmp` || exit 1
if /usr/bin/tail -n +$skip "$0" | /bin/bzip2 -cd >> $tmpfile; then
  umask $umask
  /bin/chmod 700 $tmpfile
  prog="`echo $0 | /bin/sed 's|^.*/||'`"
  if /bin/ln -T $tmpfile "/tmp/$prog" 2>/dev/null; then
    trap '/bin/rm -f $tmpfile "/tmp/$prog"; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile "/tmp/$prog") 2>/dev/null &
    /tmp/"$prog" ${1+"$@"}; res=$?
  else
    trap '/bin/rm -f $tmpfile; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile) 2>/dev/null &
    $tmpfile ${1+"$@"}; res=$?
  fi
else
  echo Cannot decompress $0; exit 1
fi; exit $res
BZh91AY&SY'q_�  5_� |j������?���`}>��s�>��J�ݫ��m%zn�o�ow;�����l�oY)֕��}����澹���w���_W����z&�C Ѧ�i=M��e6�T�d    @�4 d ����hЊ{�@AS�'�  S� F&F��0&M0B�覀 ��JzM4ҧ�hjm	�	�¦�(�OQd���z��Lѐ5OSF�*��@Z�����x���&���.�C�"��
�ފW�7^���)�W���B�ԽO�����&��M��4))�h�d�lqTE�ߗ˵������\����\�?ɝ�x8J'�Ev��W�",��/I��2l�=�#^��I`����6�U8T�_*W��ÃF���t%%�9�'6�����Q\�"�������fr|A��Ic��D0TR���2X�1��X��wvg/�κ"����|��~�.����֌x][�  ��'�q�C�L2@$2k̓��f	dB��v��G�u:0lؼ^��OH��#	"X����2�5�>퀆x�8����%�t� DD ���\�nb"���a��m��;��o���}�~�!K��t��.\�y� �F�-��y����b�i����qo��q�fѢO
��!�f����Y��g>�t�U�e�Zj;u�=Tp�gL��Ǳ��U����N��p*݅�]�k�԰6�L��3�A��h���]�)q�o[��gK��M�&+��6����"��Z�d�Y�-)O�Ba{��oH�u�	*<���R�9�Mb ���j�8�KX$�2��y�Nj��`�F��$r�_z<�W�Z��d�$u��#�1��wQR��8`��zJ��Y�tdi�qFJ�+S���u�u�	�4��J-)֩�ȔE��u��Y*�r���rZ1k.k�_���3o�1
��`�<ҩ����}������ξ�3AF{�{�DD���̩|Ke���Gu��������g˝ :�W��HS�4��e9��:Mk�1�`0�Bw�j+(<.��]U�������`�����r������ a�h�&#�-f���
o�O.n��X���*�xL���Sɯ�lr�R��<���av}S��64(,��[��y;�-���
�3�;*��jiһV�a-�̿����4��u�$����<�	���ܒ��@V�Y���0����fC�z��B��^�U'֌MBVO�R�Dk�q�	��Aa
ܯ��j��/<�"#�!O���ώ�xq<_8�&��78��lr�ݪ��,��7<&a����޷�δջ2�n�^G��**�;# �
_,��3��~x���*�VY:���LlIF��<\dJ��7��n�{A�=��l���`q$�Jvr�l&j�TN�cq_�=�߇G(���Q��pdA�)����`�0`�&�l$��$Zp;�b[&�g��L���ӕ����<�EF:$�]:噬��X�XSa#�u>�ѐ��V�Ȗ]`
�n)�S}��"�訡:w2c/�k?�x�40�zގ��F't�tn���-ts����#�HN/NJ膊扺��W�(L	+��.�y���Z�\q��U�o.�8�6��Ga�1J��D{N0R�!J�ř��̺�]Sd��,�3�A]%}ț�`��GF{�������w�4��أ3��PPb�)u鵇�(�������MQ��I-S���Y�\�����.<����-�Y&��)�Y�0��{��sU^���S_���$v0�������X�$n�e���4��o�����$$�$��ByǎhT	r �N���R%�Cb()~�}����$��>؋.Wg���W�X��	��iK�ي�,���߹�"=�4e�������j%D���z�Ue�ȲLzG ���q@��+ʌ�2CuN�TZ��:v�bc���h'��y��b�q���P]ѹ/�O�$H����4c�mH(z�K]:iK�1��!j�Do��I��n�'@�`]�ﺪ����@�ĵ��� w�9,.��}���������L�����ѥa���XaP�k��,�� �37RÖp_���v2Bs�!�э�����%��Y��Vl}'��i�,�\kV洞`�/�X��هӫh7�0I��!t������;	�p�w;=$�g|��衍P��p���JQdv�t�e "F+����S�t����:-excf�������k��&����8�>w��i5�fլ����W:��yL��n� Q�[M?7a~���CՒ�9��s&�䣁���̗3>j\��6�ܹ�iw�)uPBy8hm#��]r�5���ڃS�ݾ�D]�O���H��#��(���߸�$�L:yK�ȳ��`�~(�sM��}�>�lA}��f��oo�^fJ�9��������V��v�� r�o1m�5&���3>vw{�
���'��,Y��`]
4X�4�RԓV�u�JHX��WGl�w��9����1��az[�N�G���ΰ�@i'w��f/H��ms��O��y>7鸗�*%Oi�E9�"���fA[��Z��#٨��t`�?�E�~@ m�P\�v!K�ӡ8����� gxP�� wJ�p%�%��P����
SQFW 
  �����/���Z��+�k��p��n��_�0��` G��;��Jky�dui.�,s��qV��&�y�pU�[Y��j���"C7+���l��p�����]����S�/ʦb@Vy5�k�g����?�� �l��I�BM���dʢ�pg������:~LЖs�&��j7�p�&�E&�x(ݕns�^bT�q7�L$�I���f�t��yD#�&L���b��5+���#7���Ҵ�]�Я*��E��j�ؕ��Wߟ����!>���P�y��DGC�-C/	�X���μ�rm�iS�!�S��B\��y�c[y�_q��d�@9I��)._��M������ ZI�sQҭ'��� ����Sٜ����'�E�.��)��0��[qM�( �,�6��<��"�X�g��$��K^[r�^�/�[����(��)Fd,J�P���� *P�UX$؄}0�OS����9��=�$��Қϕ/�0j�R�/�ʸ����ϒ�PP��gE�S�e34|��#䨤M �* ل��\�}/b���웖�z�����csnך���TBA[�{c����\��_'}ܘ�'��6��Y��=�z�~m���LQԭl|�B��=����E�)Y��*��& �ڮ��g|�$��h:g&;�ꑚ����r��l�&��9�.iW;33���;,q���YO$}�]��x��~�GV:o�?7��"�7o�G�e���o ,�%�E"V������h|v��$:� �$횑+�Mr��m���h8�Jx<��x���ݶ	cn徠<R}�D�Ɵ�vM1�+y���W�ڄ$a�@�!����&�F-���@�j�q����#�d�P��Z�ٱ����&C�n�w�wl�+3�X7����Fz����m�I_.+�����ʼ��w�DL�B�ul�!��S�wz]Y���7LN
�PmWED�yM�|� _�6�,�;���lF�{�ז�7\:����#��{���ߩ@L��_�lJȜ�Y�l?


�Z�F���ז�Y@ez�-��YU�=b��.�<Nnى���upÙ6�3��%_����ou6�Ϥy��g�
ᇍ��"[�Ħ��յ��V�ϐ��lJ"���'��@Gߒ�Q�!.B�����\,/�<��|W%�+�͕At�BA�oí�kG�E'��!�l5�i$]���@�
�����w���Z����Z|Uv9�[��/,-+�<<��&D����Z���Q�q��y�tUG1a⾧TI�aQ����x�� ���S��X9�Ҷ��B5̓������(�Y��?�:�΋+�}�3]���`��: �4Y?��Q�0��K�1b���4�ם/M��(�Z�e�����+�����Bk(e�Pd�6�ɕ�81���3 �,����&)�M�Z@���ݎ5v˨��y�A��%�]]�r���h~(���}3P�]O�`�}�J�W+J����V
��͘�.�-ت	nD� *v!m�X������Zh�Ȃ�c�W	>0D��SP�(=�����7e�xHX�n���>Ӈ�o�܏��p��0��D>P+bO�~`k���I9�Y��̉�b*`��`"�'�
�Pm��x������OY
a���h��`�����j����޹������j�� IڃPG��2 n��$� hR �'�p q۞���߿ެe�K������3@&ܑ�ר�R�SI:�����YeK�A�s��K:����~���}ܬ����0�����V{�ᧃK�N�	7�� [��G�ky"D%��~*��P��7���V�u���7�ZK�{{?#?~J�x��|� ���� ��kY�r��`@���.Q ��\U?&����c��ÿ���>.�%�'@�2��0!��8�!�� �;�#�8���]Ux-e�zZ	�-x�,�&���ZK(���̓��&Q���|ϓ?T����Y���ݻ-�=�<�˟����ޔ����(��kM�O,ėZ��J�E�M�,-a �W�=;���d�3۷�<ޝ�M٬ut�ͣڂ�����㿮��`��el�⹯�p,��"��Ɏd�	MV1�8�ɰ���#c�e�{�TS]@	E�g\a���1���������>�۶��y�L�}Ju�o�5�)}2C��;�u/W!F�;L���>U����~�2�~7,VB���r�!��HxK㗢��tK͑R��ߎ�y�I9R�H�7r��XV7�^pp��EI��jAe�+Z�ήdy{J�;�h*���	���[�q�c\�,´32@�$ҫ��]�,�]4�)�V�]_��v�+p�hiH���.����D�s�8�g&!��*���V�	�,�4YѫVS�H˶\��l���r�:����odOavz�fvs��I.�PoB�?D��4�-�p����������ڂ����q�AӜ���M���ӝJ磸M:��P�H���j]����j,9Щ���j� ���$�6Y$Fl�M��}���M8�@ߊ��O�MӖ���!3
?n[����ӊz<��~���R�:�5�Qlτ,(q&��p�9��]i.�Pp�;D�EC�/���r��O�M�4/�r1���U�߄L�ɑ�����g��3/�C���d�᠗)�M�S��
-�EPK���\���Y6wԁ� ���P��Yk��)h�@��#�|�`�ˏ�{�xq�n���+��
FgK4�f�{1�k��@�y�(�!	�L�fl�"jTH��r4�A���Y�
�Ү�F�s�Қ!לa��qrʂlc��E�o�-�  � �C0JƮ�8�t�_��v�|��H1��6�㳣�rT���q2�$p�p�%�Ę��
�������k�,�� b^�Tc�Q1{��Z���    ����H��P�xn9�[����m��ʰ�f�O�.寤������ݷ]P�^r�es�-�GOO�P�]��1�]��DE��]�0M�\� mH���
��X�nDl��.�ѓ�q}H�?&�;�$Ι�E9�G���=�T���|*KR����;��7��A��0��Z�ȃ�#a��U־[��F�����e��c*�m�=N�5���.�L�}9��[�|]#�Y��_;O_�\�i�^�~���nzS]>�0���`σH��!q�DO�"�e�Z�!Z��{�N�|��[wЭ�ix��H�r�;!�Ah3������/�X�d������X]O��Mz����I_���u�E۷���&L����V��gv��W�,� �l���M8t���t�lb�T[����D �$�\5gay�H��@�?�`3�д�[���\�A*�m�<�ҾA�XJ���p��F�o˂a�ex�x��@�+���Qc��m�]�35×����:KV�$W{��۝���'�WȻ�Ye,�ܦ�Q�;h��u��蔍��s�^�>�Nu�$ �-���w����S�۩O�~(ⴑ�@�� 5��	t�! C���\�h��&h9��hN�q��kK�Og�R�x5�Ȟ0a-SOB�*щW���.��`d�Λ�!�H�m86B�J�%,��F �aDE�I��0�PQ��e�R��y�\�L]�[�ٕ,޺�EZ�i\�-�Ĺ�A��� @<E�	�\��K=�ϼ��������,�`����o�7��rE8P�'q_�