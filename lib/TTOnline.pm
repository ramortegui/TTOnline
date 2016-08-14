package TTOnline;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

post '/' => sub {
  my $name = param('name');
  my $value = param('value');
  my $action = param('action');

  my $tt = session('tt') || {};
  if( $action eq 'add' ){
    my $tmp;
    my $str = "\$tmp = $value;";
    eval $str;
    $tt->{$name} = $tmp;
  }
  elsif( $action eq 'del' ){
    delete $tt->{$name};
  }
  session->write('tt',$tt);
  redirect "/";
};

get 'ajax/preview' => sub {
  my $code = param('code');
  my $template = Template->new();
  my $html;
  $template->process(\$code, session('tt'),\$html);
  return to_json({ html => $html });
};

true;
