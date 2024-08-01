module multiplier(input logic [15:0]a1, b2, output logic [31:0]s);
logic [15:0]carry;
logic [15:0]out;
logic line[0:15];
logic [15:0]intrm21;
logic intrm[1:328];
logic carry[0:358];
always_comb begin
s[0] = (a[0]&b[0]);

add FA1(a[1]&b[0],a[0]&b[1],0,carry[0],s[1]);

add FA2(a[2]&b[0],a[1]&b[1],carry[0],carry[1],intrm[1]);
add FA3(intrm[1],a[0]&b[2],0,carry[2],s[2]);

add FA4(a[3]&b[0],a[2]&b[1],carry[1],carry[3],intrm[2]);
add FA5(intrm[2],a[1]&b[2],carry[2],carry[4],intrm[3]);
add FA6(intrm[3],a[0]&b[3],0,carry[5],s[3]);

add(a[4]&b[0],a[3]&b[1],carry[3],carry[6],intrm[4]);
add(intrm[4],a[2]&b[2],carry[4],carry[7],intrm[5]);
add(intrm[5],a[1]&b[3],carry[5],carry[8],intrm[6]);
add(intrm[7],a[0]&b[4],0,carry[9],s[4]);

add(a[5]&b[0],a[4]&b[1],carry[6],carry[10],intrm[7]);
add(intrm[7],a[3]&b[2],carry[7],carry[11],intrm[8]);
add(intrrm[8],a[2]&b[3],carry[8],carry[12],intrm[9]);
add(intrm[9],a[1]&b[4],carry[9],carry[13],intrm[10]);
add(intrm[10],a[0]&b[5],0,carry[14],s[5]);

add(a[6]&b[0],a[5]&b[1],carry[10],carry[15],intrm[11]);
add(intrm[11],a[4]&b[2],carry[11],carry[16],intrm[12]);
add(intrrm[12],a[3]&b[3],carry[12],carry[17],intrm[13]);
add(intrm[13],a[2]&b[4],carry[13],carry[18],intrm[14]);
add(intrm[14],a[1]&b[5],carry[14],carry[19],intrm[15]);
add(intrm[15],a[0]&b[6],0,carry[20],s[6]);

add(a[7]&b[0],a[6]&b[1],carry[15],carry[21],intrm[16]);
add(intrm[16],a[5]&b[2],carry[16],carry[22],intrm[17]);
add(intrrm[17],a[4]&b[3],carry[17],carry[23],intrm[18]);
add(intrm[18],a[3]&b[4],carry[18],carry[24],intrm[19]);
add(intrm[19],a[2]&b[5],carry[19],carry[25],intrm[20]);
add(intrm[20],a[1]&b[6],carry[20],carry[26],intrm[21]);
add(intrm[21],a[0]&b[7],0,carry[27],s[7]);

add(a[8]&b[0],a[7]&b[1],carry[21],carry[28],intrm[22]);
add(intrm[22],a[6]&b[2],carry[22],carry[29],intrm[23]);
add(intrrm[23],a[5]&b[3],carry[23],carry[30],intrm[24]);
add(intrm[24],a[4]&b[4],carry[24],carry[31],intrm[25]);
add(intrm[25],a[3]&b[5],carry[25],carry[32],intrm[26]);
add(intrm[26],a[2]&b[6],carry[26],carry[33],intrm[27]);
add(intrm[27],a[1]&b[7],carry[27],carry[34],intrm[28]);
add(intrm[28],a[0]&b[8],0,carry[35],s[8]);

add(a[9]&b[0],a[8]&b[1],carry[28],carry[36],intrm[29]);
add(intrm[29],a[7]&b[2],carry[29],carry[37],intrm[30]);
add(intrrm[30],a[6]&b[3],carry[30],carry[38],intrm[31]);
add(intrm[31],a[5]&b[4],carry[31],carry[39],intrm[32]);
add(intrm[32],a[4]&b[5],carry[32],carry[40],intrm[33]);
add(intrm[33],a[3]&b[6],carry[33],carry[41],intrm[34]);
add(intrm[34],a[2]&b[7],carry[34],carry[42],intrm[35]);
add(intrm[35],a[1]&b[8],carry[35],carry[43],intrm[36]);
add(intrm[36],a[0]&b[9],0,carry[44],s[9]);

add(a[10]&b[0],a[9]&b[1],carry[36],carry[45],intrm[37]);
add(intrm[37],a[8]&b[2],carry[37],carry[46],intrm[38]);
add(intrrm[38],a[7]&b[3],carry[38],carry[47],intrm[39]);
add(intrm[39],a[6]&b[4],carry[39],carry[48],intrm[40]);
add(intrm[40],a[5]&b[5],carry[40],carry[49],intrm[41]);
add(intrm[41],a[4]&b[6],carry[41],carry[50],intrm[42]);
add(intrm[42],a[3]&b[7],carry[42],carry[51],intrm[43]);
add(intrm[43],a[2]&b[8],carry[43],carry[52],intrm[44]);
add(intrm[44],a[1]&b[9],carry[44],carry[53],intrm[45]);
add(intrm[45],a[0]&b[10],0,carry[54],s[10]);

add(a[11]&b[0],a[10]&b[1],carry[45],carry[55],intrm[46]);
add(intrm[46],a[9]&b[2],carry[46],carry[56],intrm[47]);
add(intrrm[47],a[8]&b[3],carry[47],carry[57],intrm[48]);
add(intrm[48],a[7]&b[4],carry[48],carry[58],intrm[49]);
add(intrm[49],a[6]&b[5],carry[49],carry[59],intrm[50]);
add(intrm[50],a[5]&b[6],carry[50],carry[60],intrm[51]);
add(intrm[51],a[4]&b[7],carry[51],carry[61],intrm[52]);
add(intrm[52],a[3]&b[8],carry[52],carry[62],intrm[53]);
add(intrm[53],a[2]&b[9],carry[53],carry[63],intrm[54]);
add(intrm[54],a[1]&b[10],carry[54],carry[64],intrm[55]);
add(intrm[55],a[0]&b[11],0,carry[65],s[11]);

add(a[12]&b[0],a[11]&b[1],carry[55],carry[66],intrm[56]);
add(intrm[56],a[10]&b[2],carry[56],carry[67],intrm[57]);
add(intrrm[57],a[9]&b[3],carry[57],carry[68],intrm[58]);
add(intrm[56],a[8]&b[4],carry[58],carry[69],intrm[59]);
add(intrm[59],a[7]&b[5],carry[59],carry[70],intrm[60]);
add(intrm[60],a[6]&b[6],carry[60],carry[71],intrm[61]);
add(intrm[61],a[5]&b[7],carry[61],carry[72],intrm[62]);
add(intrm[62],a[4]&b[8],carry[62],carry[73],intrm[63]);
add(intrm[63],a[3]&b[9],carry[63],carry[74],intrm[64]);
add(intrm[64],a[2]&b[10],carry[64],carry[75],intrm[65]);
add(intrm[64],a[1]&b[11],carry[64],carry[76],intrm[66]);
add(intrm[66],a[0]&b[12],0,carry[77],s[12]);


add(a[13]&b[0],a[12]&b[1],carry[66],carry[78],intrm[66]);
add(intrm[66],a[11]&b[2],carry[67],carry[79],intrm[67]);
add(intrrm[67],a[10]&b[3],carry[68],carry[80],intrm[68]);
add(intrm[68],a[9]&b[4],carry[69],carry[81],intrm[69]);
add(intrm[69],a[8]&b[5],carry[70],carry[82],intrm[70]);
add(intrm[70],a[7]&b[6],carry[71],carry[83],intrm[71]);
add(intrm[71],a[6]&b[7],carry[72],carry[84],intrm[72]);
add(intrm[72],a[5]&b[8],carry[73],carry[85],intrm[73]);
add(intrm[73],a[4]&b[9],carry[74],carry[86],intrm[74]);
add(intrm[74],a[3]&b[10],carry[75],carry[87],intrm[75]);
add(intrm[75],a[2]&b[11],carry[76],carry[88],intrm[76]);
add(intrm[76],a[1]&b[12],carry[77],carry[89],intrm[77]);
add(intrm[77],a[0]&b[13],0,carry[90],s[13]);

add(a[14]&b[0],a[13]&b[1],carry[78],carry[91],intrm[78]);
add(intrm[78],a[12]&b[2],carry[79],carry[92],intrm[79]);
add(intrrm[79],a[11]&b[3],carry[80],carry[93],intrm[80]);
add(intrm[80],a[10]&b[4],carry[81],carry[94],intrm[81]);
add(intrm[81],a[9]&b[5],carry[82],carry[95],intrm[82]);
add(intrm[82],a[8]&b[6],carry[83],carry[96],intrm[83]);
add(intrm[83],a[7]&b[7],carry[84],carry[97],intrm[84]);
add(intrm[84],a[6]&b[8],carry[85],carry[98],intrm[85]);
add(intrm[85],a[5]&b[9],carry[86],carry[99],intrm[86]);
add(intrm[86],a[4]&b[10],carry[87],carry[100],intrm[87]);
add(intrm[87],a[3]&b[11],carry[88],carry[101],intrm[88]);
add(intrm[88],a[2]&b[12],carry[89],carry[102],intrm[89]);
add(intrm[89],a[1]&b[13],carry[90],carry[103],intrm[90]);
add(intrm[90],a[0]&b[14],0,carry[104],s[14]);


add(a[15]&b[0],a[14]&b[1],carry[91],carry[105],intrm[91]);
add(intrm[91],a[13]&b[2],carry[92],carry[106],intrm[92]);
add(intrrm[92],a[12]&b[3],carry[93],carry[107],intrm[93]);
add(intrm[93],a[11]&b[4],carry[94],carry[108],intrm[94]);
add(intrm[94],a[10]&b[5],carry[95],carry[109],intrm[95]);
add(intrm[95],a[9]&b[6],carry[96],carry[110],intrm[96]);
add(intrm[96],a[8]&b[7],carry[97],carry[111],intrm[97]);
add(intrm[97],a[7]&b[8],carry[98],carry[112],intrm[98]);
add(intrm[98],a[6]&b[9],carry[99],carry[113],intrm[99]);
add(intrm[99],a[5]&b[10],carry[100],carry[114],intrm[100]);
add(intrm[100],a[4]&b[11],carry[101],carry[115],intrm[101]);
add(intrm[101],a[3]&b[12],carry[102],carry[116],intrm[102]);
add(intrm[102],a[2]&b[13],carry[103],carry[117],intrm[103]);
add(intrm[103],a[1]&b[14],carry[104],carry[118],intrm[104]);
add(intrm[104],a[0] ~& b[15],1,carry[119],s[15]);

line[0] = b0&a[15];
line[1] = line[0]&a[15];

add(line[0],    line[1],    carry[105], carry[120],intrm[105]);
add(intrm[105], a[14]&b[2], carry[106], carry[121], intrm[106]);
add(intrm[106], a[13]&b[3], carry[107], carry[122], intrm[107]);
add(intrm[107], a[12]&b[4], carry[108], carry[123], intrm[108]);
add(intrm[108], a[11]&b[5], carry[109], carry[124], intrm[109]);
add(intrm[109], a[10]&b[6], carry[110], carry[125], intrm[110]);
add(intrm[110], a[9]&b[7], carry[111], carry[126], intrm[111]);
add(intrm[111], a[8]&b[8], carry[112], carry[127], intrm[112]);
add(intrm[112], a[7]&b[9], carry[113], carry[128], intrm[113]);
add(intrm[113], a[6]&b[10], carry[114], carry[129], intrm[114]);
add(intrm[114], a[5]&b[11], carry[115], carry[130], intrm[115]);
add(intrm[115], a[4]&b[12], carry[116], carry[131], intrm[116]);
add(intrm[116], a[3]&b[13], carry[117], carry[132], intrm[117]);
add(intrm[117], a[2]&b[14], carry[118], carry[133], intrm[118]);
add(intrm[118], a[1] ~& b[15], carry[119], carry[134], s[16]);



add(line[0],line[1],        carry[120], carry[135],intrm[119]);
add(intrm[119], a[15]&b[2], carry[121], carry[136], intrm[120]);
add(intrm[120], a[14]&b[3], carry[122], carry[137], intrm[121]);
add(intrm[121], a[13]&b[4], carry[123], carry[138], intrm[122]);
add(intrm[122], a[12]&b[5], carry[124], carry[139], intrm[123]);
add(intrm[123], a[11]&b[6], carry[125], carry[140], intrm[124]);
add(intrm[124], a[10]&b[7], carry[126], carry[141], intrm[125]);
add(intrm[125], a[9]&b[8], carry[127],  carry[142], intrm[126]);
add(intrm[126], a[8]&b[9], carry[128], carry[143], intrm[127]);
add(intrm[127], a[7]&b[10], carry[129], carry[144], intrm[128]);
add(intrm[128], a[6]&b[11], carry[130], carry[145], intrm[129]);
add(intrm[129], a[5]&b[12], carry[131], carry[146], intrm[130]);
add(intrm[130], a[4]&b[13], carry[132], carry[147], intrm[131]);
add(intrm[131], a[3]&b[14], carry[133], carry[148], intrm[132]);
add(intrm[132], a[2] ~& b[15], carry[134], carry[149], s[17]);

add(line[0],line[1],        carry[135], carry[150], intrm[133]);
add(intrm[133], a[15]&b[2], carry[136], carry[151], intrm[134]);
add(intrm[134], a[15]&b[3], carry[137], carry[152], intrm[135]);
add(intrm[135], a[14]&b[4], carry[138], carry[153], intrm[136]);
add(intrm[136], a[13]&b[5], carry[139], carry[154], intrm[137]);
add(intrm[137], a[12]&b[6], carry[140], carry[155], intrm[138]);
add(intrm[138], a[11]&b[7], carry[141], carry[156], intrm[139]);
add(intrm[139], a[10]&b[8], carry[142], carry[157], intrm[140]);
add(intrm[140], a[9]&b[9], carry[143], carry[158], intrm[141]);
add(intrm[141], a[8]&b[10], carry[144], carry[159], intrm[142]);
add(intrm[142], a[7]&b[11], carry[145], carry[160], intrm[143]);
add(intrm[143], a[6]&b[12], carry[146], carry[161], intrm[144]);
add(intrm[144], a[5]&b[13], carry[147], carry[162], intrm[145]);
add(intrm[145], a[4]&b[14], carry[148], carry[163], intrm[146]);
add(intrm[146], a[3] ~& b[15], carry[149], carry[164], s[18]);

add(line[0],    line[1],    carry[150], carry[165], intrm[147]);
add(intrm[147], a[15]&b[2], carry[151], carry[166], intrm[148]);
add(intrm[148], a[15]&b[3], carry[152], carry[167], intrm[149]);
add(intrm[149], a[15]&b[4], carry[153], carry[168], intrm[150]);
add(intrm[150], a[14]&b[5], carry[154], carry[169], intrm[151]);
add(intrm[151], a[13]&b[6], carry[155], carry[170], intrm[152]);
add(intrm[152], a[12]&b[7], carry[156], carry[171], intrm[153]);
add(intrm[153], a[11]&b[8], carry[157], carry[172], intrm[154]);
add(intrm[154], a[10]&b[9], carry[158], carry[173], intrm[155]);
add(intrm[155], a[11]&b[10], carry[159], carry[174], intrm[156]);
add(intrm[156], a[10]&b[11], carry[160], carry[175], intrm[157]);
add(intrm[157], a[9]&b[12], carry[161], carry[176], intrm[158]);
add(intrm[158], a[8]&b[13], carry[162], carry[177], intrm[159]);
add(intrm[159], a[7]&b[14], carry[163], carry[178], intrm[160]);
add(intrm[160], a[6] ~& b[15], carry[164], carry[179], s[19]);

add(line[0],    line[1],    carry[165], carry[180], intrm[161]);
add(intrm[161], a[15]&b[2], carry[166], carry[181], intrm[162]);
add(intrm[162], a[15]&b[3], carry[167], carry[182], intrm[163]);
add(intrm[163], a[15]&b[4], carry[168], carry[183], intrm[164]);
add(intrm[164], a[15]&b[5], carry[169], carry[184], intrm[165]);
add(intrm[165], a[14]&b[6], carry[170], carry[185], intrm[166]);
add(intrm[166], a[13]&b[7], carry[171], carry[186], intrm[167]);
add(intrm[167], a[12]&b[8], carry[172], carry[187], intrm[168]);
add(intrm[168], a[11]&b[9], carry[173], carry[188], intrm[169]);
add(intrm[169], a[10]&b[10], carry[174], carry[189], intrm[170]);
add(intrm[170], a[9]&b[11], carry[175], carry[190], intrm[171]);
add(intrm[171], a[8]&b[12], carry[176], carry[191], intrm[172]);
add(intrm[172], a[7]&b[13], carry[177], carry[192], intrm[173]);
add(intrm[173], a[6]&b[14], carry[178], carry[193], intrm[174]);
add(intrm[174], a[5] ~& b[15], carry[179], carry[194], s[20]);

add(line[0],    line[1],    carry[180], carry[195], intrm[175]);
add(intrm[175], a[15]&b[2], carry[181], carry[195], intrm[176]);
add(intrm[176], a[15]&b[3], carry[182], carry[196], intrm[177]);
add(intrm[177], a[15]&b[4], carry[183], carry[197], intrm[178]);
add(intrm[178], a[15]&b[5], carry[184], carry[198], intrm[179]);
add(intrm[179], a[15]&b[6], carry[185], carry[199], intrm[180]);
add(intrm[180], a[10]&b[7], carry[186], carry[200], intrm[181]);
add(intrm[181], a[9]&b[8], carry[187], carry[201], intrm[182]);
add(intrm[182], a[8]&b[9], carry[188], carry[202], intrm[183]);
add(intrm[183], a[7]&b[10], carry[189], carry[203], intrm[184]);
add(intrm[184], a[6]&b[11], carry[190], carry[204], intrm[185]);
add(intrm[185], a[5]&b[12], carry[191], carry[205], intrm[186]);
add(intrm[186], a[4]&b[13], carry[192], carry[206], intrm[187]);
add(intrm[187], a[3]&b[14], carry[193], carry[207], intrm[188]);
add(intrm[188], a[5] ~& b[15], carry[194], carry[208], s[21]);


add(line[0],    line[1],    carry[195], carry[209], intrm[189]);
add(intrm[189], a[15]&b[2], carry[196], carry[210], intrm[190]);
add(intrm[190], a[15]&b[3], carry[197], carry[211], intrm[191]);
add(intrm[191], a[15]&b[4], carry[198], carry[212], intrm[192]);
add(intrm[192], a[15]&b[5], carry[199], carry[213], intrm[193]);
add(intrm[193], a[15]&b[6], carry[200], carry[214], intrm[194]);
add(intrm[194], a[15]&b[7], carry[201], carry[215], intrm[195]);
add(intrm[195], a[14]&b[8], carry[202], carry[216], intrm[196]);
add(intrm[196], a[13]&b[9], carry[203], carry[217], intrm[197]);
add(intrm[197], a[12]&b[10], carry[204], carry[218], intrm[198]);
add(intrm[198], a[11]&b[11], carry[205], carry[219], intrm[199]);
add(intrm[199], a[10]&b[12], carry[206], carry[220], intrm[200]);
add(intrm[200], a[9]&b[13], carry[207], carry[221], intrm[201]);
add(intrm[201], a[8]&b[14], carry[208], carry[222], intrm[202]);
add(intrm[202], a[7] ~& b[15], carry[209], carry[223], s[22]);

add(line[0],    line[1],    carry[209], carry[224], intrm[203]);
add(intrm[203], a[15]&b[2], carry[210], carry[225], intrm[204]);
add(intrm[204], a[15]&b[3], carry[211], carry[226], intrm[205]);
add(intrm[205], a[15]&b[4], carry[212], carry[227], intrm[206]);
add(intrm[206], a[15]&b[5], carry[213], carry[228], intrm[207]);
add(intrm[207], a[15]&b[6], carry[214], carry[229], intrm[208]);
add(intrm[208], a[15]&b[7], carry[215], carry[230], intrm[209]);
add(intrm[209], a[15]&b[8], carry[216], carry[231], intrm[210]);
add(intrm[210], a[14]&b[9], carry[217], carry[232], intrm[211]);
add(intrm[211], a[13]&b[10], carry[218], carry[233], intrm[212]);
add(intrm[212], a[12]&b[11], carry[219], carry[234], intrm[213]);
add(intrm[213], a[11]&b[12], carry[220], carry[235], intrm[214]);
add(intrm[214], a[10]&b[13], carry[221], carry[236], intrm[215]);
add(intrm[215], a[9]&b[14], carry[222], carry[237], intrm[216]);
add(intrm[216], a[8] ~& b[15], carry[223], carry[238], s[23]);

add(line[0],    line[1],    carry[224], carry[239], intrm[217]);
dd(intrm[217], a[15]&b[2], carry[225], carry[240], intrm[218]);
add(intrm[218], a[15]&b[3], carry[226], carry[241], intrm[219]);
add(intrm[219], a[15]&b[4], carry[227], carry[242], intrm[220]);
add(intrm[220], a[15]&b[5], carry[228], carry[243], intrm[221]);
add(intrm[221], a[15]&b[6], carry[229], carry[244], intrm[222]);
add(intrm[222], a[15]&b[7], carry[230], carry[245], intrm[223]);
add(intrm[223], a[15]&b[8], carry[231], carry[246], intrm[224]);
add(intrm[224], a[15]&b[9], carry[232], carry[247], intrm[225]);
add(intrm[225], a[14]&b[10], carry[233], carry[248], intrm[226]);
add(intrm[226], a[13]&b[11], carry[234], carry[249], intrm[227]);
add(intrm[227], a[12]&b[12], carry[235], carry[250], intrm[228]);
add(intrm[228], a[11]&b[13], carry[236], carry[251], intrm[229]);
add(intrm[229], a[10]&b[14], carry[237], carry[252], intrm[230]);
add(intrm[230], a[9] ~& b[15], carry[238], carry[253], s[24]);

add(line[0],    line[1],    carry[239], carry[254], intrm[231]);
add(intrm[231], a[15]&b[2], carry[240], carry[255], intrm[232]);
add(intrm[232], a[15]&b[3], carry[241], carry[256], intrm[233]);
add(intrm[233], a[15]&b[4], carry[242], carry[257], intrm[234]);
add(intrm[234], a[15]&b[5], carry[243], carry[258], intrm[235]);
add(intrm[235], a[15]&b[6], carry[244], carry[259], intrm[236]);
add(intrm[236], a[15]&b[7], carry[245], carry[260], intrm[237]);
add(intrm[237], a[15]&b[8], carry[246], carry[261], intrm[238]);
add(intrm[238], a[15]&b[9], carry[247], carry[262], intrm[239]);
add(intrm[239], a[15]&b[10], carry[248], carry[263], intrm[240]);
add(intrm[240], a[14]&b[11], carry[249], carry[264], intrm[241]);
add(intrm[241], a[13]&b[12], carry[250], carry[265], intrm[242]);
add(intrm[242], a[12]&b[13], carry[251], carry[266], intrm[243]);
add(intrm[243], a[11]&b[14], carry[252], carry[267], intrm[244]);
add(intrm[244], a[10] ~& b[15], carry[253], carry[268], s[25]);

add(line[0],    line[1],    carry[254], carry[269], intrm[245]);
add(intrm[245], a[15]&b[2], carry[255], carry[270], intrm[246]);
add(intrm[246], a[15]&b[3], carry[256], carry[271], intrm[247]);
add(intrm[247], a[15]&b[4], carry[257], carry[272], intrm[248]);
add(intrm[248], a[15]&b[5], carry[258], carry[273], intrm[249]);
add(intrm[249], a[15]&b[6], carry[259], carry[274], intrm[250]);
add(intrm[250], a[15]&b[7], carry[260], carry[275], intrm[251]);
add(intrm[251], a[15]&b[8], carry[261], carry[276], intrm[252]);
add(intrm[252], a[15]&b[9], carry[262], carry[277], intrm[253]);
add(intrm[253], a[15]&b[10], carry[263], carry[278], intrm[254]);
add(intrm[254], a[15]&b[11], carry[264], carry[279], intrm[255]);
add(intrm[255], a[14]&b[12], carry[265], carry[280], intrm[256]);
add(intrm[256], a[13]&b[13], carry[266], carry[281], intrm[257]);
add(intrm[257], a[12]&b[14], carry[267], carry[282], intrm[258]);
add(intrm[258], a[11] ~& b[15], carry[268], carry[283], s[26]);

add(line[0],    line[1],    carry[269], carry[284], intrm[259]);
add(intrm[259], a[15]&b[2], carry[270], carry[285], intrm[260]);
add(intrm[260], a[15]&b[3], carry[271], carry[286], intrm[261]);
add(intrm[261], a[15]&b[4], carry[272], carry[287], intrm[262]);
add(intrm[262], a[15]&b[5], carry[273], carry[288], intrm[263]);
add(intrm[263], a[15]&b[6], carry[274], carry[289], intrm[264]);
add(intrm[264], a[15]&b[7], carry[275], carry[290], intrm[265]);
add(intrm[265], a[15]&b[8], carry[276], carry[291], intrm[266]);
add(intrm[266], a[15]&b[9], carry[277], carry[292], intrm[267]);
add(intrm[267], a[15]&b[10], carry[278], carry[293], intrm[268]);
add(intrm[268], a[15]&b[11], carry[279], carry[294], intrm[269]);
add(intrm[269], a[15]&b[12], carry[280], carry[295], intrm[270]);
add(intrm[270], a[14]&b[13], carry[281], carry[296], intrm[271]);
add(intrm[271], a[13]&b[14], carry[282], carry[297], intrm[272]);
add(intrm[272], a[12] ~& b[15], carry[283], carry[298], s[27]);


add(line[0],    line[1],    carry[284], carry[299], intrm[273]);
add(intrm[273], a[15]&b[2], carry[285], carry[300], intrm[274]);
add(intrm[274], a[15]&b[3], carry[286], carry[301], intrm[275]);
add(intrm[275], a[15]&b[4], carry[287], carry[302], intrm[276]);
add(intrm[276], a[15]&b[5], carry[288], carry[303], intrm[277]);
add(intrm[277], a[15]&b[6], carry[289], carry[304], intrm[278]);
add(intrm[278], a[15]&b[7], carry[290], carry[305], intrm[279]);
add(intrm[279], a[15]&b[8], carry[291], carry[306], intrm[280]);
add(intrm[280], a[15]&b[9], carry[292], carry[307], intrm[281]);
add(intrm[281], a[15]&b[10], carry[293], carry[308], intrm[282]);
add(intrm[282], a[15]&b[11], carry[294], carry[309], intrm[283]);
add(intrm[283], a[15]&b[12], carry[295], carry[310], intrm[284]);
add(intrm[284], a[15]&b[13], carry[296], carry[311], intrm[285]);
add(intrm[285], a[3]&b[14], carry[297], carry[312], intrm[286]);
add(intrm[286], a[12] ~& b[15], carry[298], carry[313], s[28]);

add(line[0],    line[1],    carry[299], carry[314], intrm[287]);
add(intrm[287], a[15]&b[2], carry[300], carry[315], intrm[288]);
add(intrm[288], a[15]&b[3], carry[301], carry[316], intrm[289]);
add(intrm[289], a[15]&b[4], carry[302], carry[317], intrm[290]);
add(intrm[290], a[15]&b[5], carry[303], carry[318], intrm[291]);
add(intrm[291], a[15]&b[6], carry[304], carry[319], intrm[292]);
add(intrm[292], a[15]&b[7], carry[305], carry[320], intrm[293]);
add(intrm[293], a[15]&b[8], carry[306], carry[321], intrm[294]);
add(intrm[294], a[15]&b[9], carry[307], carry[322], intrm[295]);
add(intrm[295], a[15]&b[10], carry[308], carry[323], intrm[296]);
add(intrm[296], a[15]&b[11], carry[309], carry[324], intrm[297]);
add(intrm[297], a[15]&b[12], carry[310], carry[325], intrm[298]);
add(intrm[298], a[15]&b[13], carry[311], carry[326], intrm[299]);
add(intrm[299], a[15]&b[14], carry[312], carry[327], intrm[300]);
add(intrm[300], a[14] ~& b[15], carry[313], carry[328], s[29]);

add(line[0],    line[1],    carry[314], carry[329], intrm[301]);
add(intrm[301], a[15]&b[2], carry[315], carry[330], intrm[302]);
add(intrm[302], a[15]&b[3], carry[316], carry[331], intrm[303]);
add(intrm[303], a[15]&b[4], carry[317], carry[332], intrm[304]);
add(intrm[304], a[15]&b[5], carry[318], carry[333], intrm[305]);
add(intrm[305], a[15]&b[6], carry[319], carry[334], intrm[306]);
add(intrm[306], a[15]&b[7], carry[320], carry[335], intrm[307]);
add(intrm[307], a[15]&b[8], carry[321], carry[336], intrm[308]);
add(intrm[308], a[15]&b[9], carry[322], carry[337], intrm[309]);
add(intrm[309], a[15]&b[10], carry[323], carry[338], intrm[310]);
add(intrm[310], a[15]&b[11], carry[324], carry[339], intrm[311]);
add(intrm[311], a[15]&b[12], carry[325], carry[340], intrm[312]);
add(intrm[312], a[15]&b[13], carry[326], carry[341], intrm[313]);
add(intrm[313], a[15]&b[14], carry[327], carry[342], intrm[314]);
add(intrm[314], a[15] ~& b[15], carry[328], carry[343], s[30]);

add(line[0],    line[1],    carry[329], carry[344], intrm[315]);
add(intrm[315], a[15]&b[2], carry[330], carry[345], intrm[316]);
add(intrm[316], a[15]&b[3], carry[331], carry[346], intrm[317]);
add(intrm[317], a[15]&b[4], carry[332], carry[347], intrm[318]);
add(intrm[318], a[15]&b[5], carry[333], carry[348], intrm[319]);
add(intrm[319], a[15]&b[6], carry[334], carry[349], intrm[320]);
add(intrm[320], a[15]&b[7], carry[335], carry[350], intrm[321]);
add(intrm[321], a[15]&b[8], carry[336], carry[351], intrm[322]);
add(intrm[322], a[15]&b[9], carry[337], carry[352], intrm[323]);
add(intrm[323], a[15]&b[10], carry[338], carry[353], intrm[324]);
add(intrm[324], a[15]&b[11], carry[339], carry[354], intrm[325]);
add(intrm[325], a[15]&b[12], carry[340], carry[355], intrm[326]);
add(intrm[326], a[15]&b[13], carry[341], carry[356], intrm[327]);
add(intrm[327], a[15]&b[14], carry[342], carry[357], intrm[328]);
add(intrm[328], a[15] ~& b[15], carry[343], carry[358], s[31]);
end
endmodule
