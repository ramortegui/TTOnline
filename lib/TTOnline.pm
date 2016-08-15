package TTOnline;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get 'ajax/preview' => sub {
  my $code = param('code');
  my $vars = param('vars');
  session 'code' => $code;
  session 'vars' => $vars;
  my $template = Template->new();
  my $variables = from_json ($vars );
  my $html;
  $template->process(\$code, $variables ,\$html);
  return to_json({ html => $html });
};

true;
