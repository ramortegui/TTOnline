package TTOnline;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

post '/' => sub {
  my $vars = param('vars');
  session->write('vars',$vars);
  redirect "/";
};

get 'ajax/preview' => sub {
  my $code = param('code');
  my $template = Template->new();
  my $variables = from_json ( session('vars') );
  my $html;
  $template->process(\$code, $variables ,\$html);
  return to_json({ html => $html });
};

true;
