command! -range=% TOhtml :call tohtml#Convert2HTML(<line1>, <line2>)  
TOhtml
" exe "w ".b:output_file
wq!

