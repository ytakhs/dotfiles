{ ... }:
{
  programs.vim = {
    enable = true;
    settings = {
      number = true;
      expandtab = true;
    };
    extraConfig = ''
      set hlsearch
      set incsearch
      set autoindent
      set visualbell t_vb=
      set noerrorbells

      " insert mode
      inoremap <silent> <C-a> <HOME>
      inoremap <silent> <C-e> <END>
      inoremap <silent> <C-f> <Right>
      inoremap <silent> <C-b> <Left>
      inoremap <silent> <C-p> <UP>
      inoremap <silent> <C-n> <DOWN>

      " commandline mode
      cnoremap <C-a> <Home>
      cnoremap <C-e> <End>
      cnoremap <C-f> <Right>
      cnoremap <C-b> <Left>
      cnoremap <C-p> <UP>
      cnoremap <C-n> <DOWN>
    '';
  };
}
