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
    $tt->{$name} = $value;
  }
  elsif( $action eq 'del' ){
    delete $tt->{$name};
  }
  session->write('tt',$tt);
  redirect "/";
};
true;
