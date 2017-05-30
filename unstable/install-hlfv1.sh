(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �~-Y �]Ys�:�g�
j^��xߺ��F���6�`��R�ٌ���c Ig�tB:��[��;1HB�u��	7�'��ʍ��4��|
�4M�(M"�w���(�c4E���xE�_j��4�16��Nk�/���N��˽����H����4��Ӄ�����CF���h��_^��m
�+�b�c�S������|�Nup��Q�$*������W\������O���/�$�����q�2.�?� x%�2p_����˰3]�?�GSq'��B�c����$]���'�������g�^����c�?��.��.�y��S6�6J�4JS�C6�,BQ>B:>���`��x�(��M�Yc���Q��O�"^��8�>��x�Y�K)��p�u'6d�&�B�z�lC��E�)M��(�2�I}a,0���F)�[e�ւ6U�	�e���i�ϯ}�`!���x�	Z��Աc���#��sݧ(��h��:���OYz8�l%�n���Ri&������Ł��"�-T?�%�^|��}��+��K��ww�o�_���M��������èj��|���2��o�?zp�W�?J��S�O���/�?/�,�|�6o5�,�M���A.s �5e)�ɬ�m�!ǳ�Rܶ���\�&�Y��i�q��e9�k�`jZC�[�� Jq#�D�S�&e�p�u#2�q�p�)��)� �6�8�C֐��#u�D]���Ev����A܉�q�jr@1�&��Z=7rw
G� �qEPr�x=X�b�#���4y���rK;
��[0Qx�Tv��й������i,"om졸�f`p�s�,�\Í���-�ܷ
�@��Y����_1��㡹7��R1���)n�M�'
�No

�8�WňP�<�9���n$�)a7�a/�-��bc���9}���)�h'�rVr�P����]i�Y&n��Vw�t3עf��)�8>�'�"�xy2�S4�E������5���'�K
P80y�(r�r�,��t�1)m�&Fv��Ê	��R=0�6H�\�h�D�i��&C!J !P�/k<y:9�����	t	#.b�fu0���n����ڹr�Iڒ�hj�x1��C&K f�ȱh�sfы��(�e��F��=3��/��l������(^�)� �?Jj����S�?����2���������u�����Nݯv�zK qO��|h��x,fȑ8N�
��Q/!T�G��vB>$��N=��"��U�TA������^���i�$��h�o``a���x6ad1Ok�K��w��Dѭ\������5$B}ٚ8������ˇ��B�7�<6]�+�<s�y�i��}߁��{o��]~�-C��e[�*�ቪ{@k�(̶p-�#��4M93rր�6�����C�� �v~�d��Z.� ����>kr���r�Mwp�x/��-��))�D"�a�t�zr�a�:D��K}0�m�`B2���q���D���ϛX��X��P���o�m������}?��Z2��h�Y�!���:��x��_�������$U�����Ϝ�/���!*�/��_�����������x9�(NV�_~I���S�������~}��>E8�b�P6[\� �H��q���@X$�q��\֡0�\�P��Y������e����G�?�W�_� ��o���~�Ѥ���#��u�u<K�s�G ��e�?�����-ض�`FL�9i��e�l)�z�"��Ɨs�3ܠ��Ȃ�`�͍9�Z�+���u�`5J�`�Y��4��ދ_����S���������� ��/��_��W��U������S�)� �?J������+o�����o�Px$t�0�7[� -x�������]>tl�0�ެ���31��B���d�{*��< }d�ex�I&��T�[ӹg�6|�=̝�*"��"	s=����z���dް��1�?M�B�x��	����NV�;�g���5�H��q9#�����@~���-�A�%�S�q�s ��l(bK Ӑ���s'������m�2	\X�7h�y��磅iϞ�P���I`*����;����C���b��v�in��:K{��,�;�!/7;��
�(!�D��|$s�"yY��	���@N�b�Ak����S���������2�!�������KA��W����������k�����-�W�_.��+4�".��(�*�/�W�_������C�J=��HA���2p	�{�M:x�������Юoh�a8�zn��(°J",�8, �Ϣ4K��]E��~(C����!4IU�_� �Oe®ȯV+U���؜����=�i�m����?��)���H�	�S����;����^����=��n�c�Vi�ہ�8"��	�y� ���`�ʇ7y��)%�v�Y��n<��q�������D��_� ���<��?Tu�w9�P���/S
��'�j������A��˗����q��_>R�/m�X�8�!���R�;��`8�|�']����O��,�Ѕ��bD�b�cۤ��K�.F!�K�,f{X�������L8��2��VE���_���#�������?]D��� �D4L^L�ݠ�nci�x�s�X鮑&����V�p�e���+�au]��S��0"7�3�`��(�|�G�|F�T��Nc�[����&���k��3[��ލ���/m}��GЕ�W
~�%���u������'��ٗFU(e���%ȧ��DA��W^��j�<���ϝ���k�KX0�}C~v��x���?K�ߟ����q����r1��Zo�H_������~�9���9���A��=zд�æ�[&N>��)��/��#݅����A?�$��}�؄q��1r-��f��Ex�p�LNp�ɬ'��x��bs5�9jo�EsI�٠��`�uF9��z��2<�Q&�=b��Mb����k�Mba΅�x|�s�[SW�e�"Ek�
?o@���P�r<����T���xl�A�Z�n�yP�:#���6\����`t�A�	NSΦ�4o���7�ڊlt��H�,�e�S����Ӷ7���{@��p��f�	zR.�do��l��-�U].��x�4������������q���K�oa�Sxe��M��������-Q��_�����$P�:���m�G�~�Ǹ0l�^�-��If�����l�G���?�e~��P~�(�|�n#�[�������<�Z�� 컦�Oܖ����yЃ!c;9�ݔ����E%qG4�f#�e�\k�-[�)Ѷw�o�T�]K�t*�1I�4�.�S��]K$�_����4^;zz ��σ8��Х��cs �5�͑��hmւg�.��}{��Y#Yͥ.���d.���j�l��;�j��7|��N�aFHt��*�>=l<����O����� .������J�oa����?��?%�3�����A���?]��e�Z�������j�����]��\l�cV}�s9�\��[w�?F!t�Y
*������?�����z��S}�[)���	��i�P��"Y�eh��(�	�	� �]�}�pȀ�� �}�r]�q�N���P��_��~t��i�_e�}>.����)�rrط̩�f�/0DhN=���l��y�-Z����?� ��q[iXW��E��5��ľ����UQRs̡��+8��)L�Z:Yg�Q�&���F}���ش������ݹ��?J�̿�G������?Z����(V}�W)��iVh������ (�������P�����R�M#;���&��O��1��t�^���C�P�z�\#W�"�ا����4����\�+�ծj�t����M����`��?����?=}0��u����I|=���)������ֲI�ʭ�����Q���U�r}\����ꝟ���}��\���_V���W�rj�_O����ڕw�m��D��>��/9���[�⶿�k{��ӛ��µo�*�������yZ�.��au[좱��Q�����:��t�!�@t����\���X�x��}E4�]��Q�����F��;x��qf׷�r�,
=�rc�<�(��,|�?P�y�� ��[eɝ��bF�S���g���{,yˤ�>��zqowg�O�z�T���������n��A��^�}?{��|�K~�j������;55���t�x��k��5Ɖ���Y���t=�8ׅ���t{$�{��0�&,t rT�ȏ��Y<��w�Q�����[>��mO��c�p�zE7�\���.��M �|Wođ�ѐ�;0��G�qYU�����l*Ŝz]Y5�m���W�'q���v
��%|����������ۻ�׭2�^no���۩+�ہކ�ޢ;{�8·S��q�$�8��,�]���I��c�B* !�"+��Z��� 	~� ��c�Z>�B�n�J���I<�$��L����\�c�������ׯ�sN�-4���[��Mgs���&�+��PB��!�P���):ː��jx0ہ��K�r�̭t6�����ֵc��'	5[_��h6E&��;6�z`Z��Xtk5 �z��tL�%�Y�mA�	%b´�w���誫�� 8��۵�����dh�Z�p�+��. ����&̸x���Ȗ��]̀�	��xl��&�L|t�V�.�w$M1�>��\~�C��t�a��wZ�~�&����}�x��s�M�:f��5���iUV�i�2b�*��|6�V����r�<�J��Ҕ�ꨉ�ة���nߜ�EM�[���MWa��M��<�bg�ӵ�8u��lpX�S�oN��Ng'&~���zD��uvu�ή��~$�j�S[�ۏ���ߣ�9��i�]x�I-�����n*�f�&,NT�q�v�?m�\nx�Q0{:��拰�~|A���D疮�kf���2�xT�&����*L��a��h+�����|](8-��-_�0U䕜���)��-�� }L�7��Mk��U��uT��|ú��Yjt�jK\Z������t��Ѿ^����ْ�	n�0��~�^��G�=��h��IZ��G�KR�:Sf:.K���a�̘�{[���7��=���ɹ{?|CX���(��j�Ɇ��UE��]��څ�o����]]����5XUb����
�͛F��+�G��|�M66<��Zu��ǋ���,~�������?�~�H��Ai��Υ����S߻�}��7����ޠ�穇0�B|����x��^b�ϋx�������
D���� &�\�}"�M�����K]���{>�`=�o��q��O�˭g����/�<+���|������<�a\y��o\o2���|��k׿r�RcX07��N7�������n�q���&�<r���l31`�Aʜ�k���5��<?D�#,����6~c�\6,${���
Tz7���D��{����9��������sB�˵KsPU��
�b�>�f����q'r�b3<���fn	���$>���m�6tW�4U�[��F��*l���Y6φ';�%\���Lx�,8f��vY����P˵v3e�C��J��h�FJ�*EY��q5S�H	)�y4�6P)e�Ut]ex�C~?�g44��7+���j�8r��K�a�:L�M��ȗOD�����̱���"���'8%���Ԍ�� �{jn��{���R߈gZ>�%À��IO2ʥ��.گ
ͤ��$�j�8�E���Nk ��SpZ�E�|�-�`u:d��q��b�j�:h�"�X�':>1�.!���)��%d%{�]����^��`�N=��Q�~�Q�&ct0��y�a��F�Z�ӲB����q_�g۩p��O%K�ZR�9��6#� �Ŏ�F��W��9)˚X�eϛ�-�G�DW+����3*���TK@�\q,a�����AN�ģ�p���XgX��D9ӑ�L��dd_�bL���꠽ϜNYHNa�FYabl����e� W$s%��,G�d�*K\���@y�gc�2�b��x5T0��bq5�&۬Lb�����r���ax�L:�b�6W-J��7�H�C��Q���*Kb��W(��xein�,q<19#�jB�io�R��G�{�Rol��%��(v��� Bz���eu��M�k�:�l	�7�%��j�{:e��醒�H?���*H�c\Ɠ�U[R�#��k�����q�{���RE�Pv0ʳ�r�ѢxJ*��)/[���-N�m)�A�J��.t)�𕚾�˧e��F)�/]����l����l��l;�H3�g�qpwIotE�@ޅ\ۺ�A��K�;v� o���3�����������l#W��l�9_UV�k��j���a�+�f�]�u�����]^��m�"��+�.Z��2��F����>RD�K*������jSȊFWoX_5dk��{)xF�=#?�Dd�.���"np�՚\c,"oA.o��g��6v��g\�m��ι�\�zf��/�27�}a�X�F�j9�V�^(|��8�ʳ�͖�����=�u� ߾.���bR��ב�#f`Ŋ�#?Ev0(�dU7?���
 �ˊ�o?�c۟���'��?o#��F�w��<��y)�������i{�A�CSZ3W��0*v��=�^~i�A���Ց�Y[�E��ɠa-:+�p����V�,88s4�Y��
X��|��":�'����H��h��2�3�JkX�����iD�WB}�Ec�=#�
��N�G�F��-��TX�1J�;\���s�n�iC���q�ƒ>K�#{0q �5��,&{>B��R�<&�Ocf<4KZC�����&R� �0�Qq�?�������I�	�kh���qȊ���1�H�%�����pY%�����o6�����G���!3HHᎬ���1j�n�04@(��_���ǥ�Qd"z�q��p��1��Xϡ���6�T�uι�l�CS�d>��g�0f{v�"A��2܋\�3��3�{�������c|�O�ayo���D��8��M��\p�oU��4Vm�����M�Ϗ�%2Q�|�#���*�֢r���Ar!(2����Ef����|��,k8?&V.��!���R����r�+�p,�!1��1��	a\�@��h8#�UCH Y��4ڊ���#U�?��F�@�V2
�$�h�49���B�R���|�/R��W�b7�;��0���J�.���_���0tP��]oL
0�aݯdjdZTå�8�A�\
c��x�� �����p��7�ԞB��wyZ4��J!���Ӥ�Ѭ�ұK;o�a9���ߛq����.F�6rʼ�v�rl��($�A�m�&x�
�E�.��ёr]�'t{�-��L�͉oO#�d����!����.�ym��`{Z(�H*��� �����^����#KqT�I�y\D. w�n�M`3�~��������C��؟��/=���؋�}���A�1�᭮:<|��nNZL+'��s'�?q���?~��y[p︾�����Sl���]��>�����O~��y���~�����ȿ'�����In�i���-���hL�5j�r�w����w?���(o�g��#���~�>���/1ȯ��s�Ο������t���ӡv:4�&�P;�������N@�	H;�N���P;����^��S�-o#��)H���@��*e���)�-��VBgρzn��s&�����#���_G^��&��8<ǭsxΧT�S��3p��1�׌gp��X���`;_/�M�Y�i9sf�h�3gƙ�Lp��8���m�3s���g�s;f��8�0�)Bk��6_]��9�9ϋ_jw��c��INr�����M��F�  