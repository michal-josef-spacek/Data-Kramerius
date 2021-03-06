package Data::Kramerius;

use strict;
use warnings;

use Data::Kramerius::Object;
use Text::DSV;
use Unicode::UTF8 qw(decode_utf8);

our $VERSION = 0.06;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	$self->{'kramerius'} = [];

	# Load data.
	$self->_load_data;

	# Object.
	return $self;
}

sub get {
	my ($self, $id) = @_;

	foreach my $obj (@{$self->{'kramerius'}}) {
		if ($obj->id eq $id) {
			return $obj;
		}
	}

	return;
}

# List of Kramerius systems.
sub list {
	my $self = shift;

	return @{$self->{'kramerius'}};
}

sub _load_data {
	my $self = shift;

	# Read data.
	my $kramerius_data;
	my $dsv = Text::DSV->new;
	while (my $data = <DATA>) {
		chomp $data;
		my ($version, $id, $name, $url) = $dsv->parse_line($data);
		push @{$self->{'kramerius'}}, Data::Kramerius::Object->new(
			'id' => $id,
			'name' => decode_utf8($name),
			'url' => $url,
			'version' => $version,
		);
	}

	return;
}

1;

=pod

=encoding utf8

=head1 NAME

Data::Kramerius - Information about all Kramerius systems.

=head1 SYNOPSIS

 use Data::Kramerius;

 my $obj = Data::Kramerius->new;
 my $kramerius_obj = $obj->get($kramerius_id);
 my @kramerius_objs = $obj->list;

=head1 DESCRIPTION

Kramerius is an open source software solution for accessing digital documents.
Homepage of project is in L<https://system-kramerius.cz/>.

=head1 METHODS

=head2 C<new>

 my $obj = Data::Kramerius->new;

Constructor.

Returns instance of object.

=head2 C<get>

 my $kramerius_obj = $obj->get($kramerius_id);

Get Kramerius object defined by id.

Returns Data::Kramerius::Object instance.

=head2 C<list>

 my @kramerius_objs = $obj->list;

List all kramerius systems.

Returns list of Data::Kramerius::Object instances.

=head1 EXAMPLE

 use strict;
 use warnings;

 use Data::Kramerius;
 use Unicode::UTF8 qw(encode_utf8);

 my $obj = Data::Kramerius->new;
 my $kramerius_mzk = $obj->get('mzk');

 # Print out.
 print 'Id: '.$kramerius_mzk->id."\n";
 print 'Name: '.encode_utf8($kramerius_mzk->name)."\n";
 print 'URL: '.$kramerius_mzk->url."\n";
 print 'Version: '.$kramerius_mzk->version."\n";

 # Output:
 # Id: mzk
 # Name: Moravsk?? zemsk?? knihovna
 # URL: http://kramerius.mzk.cz/
 # Version: 4

=head1 DEPENDENCIES

L<Data::Kramerius::Object>,
L<Text::DSV>,
L<Unicode::UTF8>.

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Data-Kramerius>

=head1 AUTHOR

Michal Josef ??pa??ek L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

?? 2021 Michal Josef ??pa??ek

BSD 2-Clause License

=head1 VERSION

0.06

=cut

__DATA__
version:code:name:url
3:ABA001:N??rodn?? knihovna:https\://kramerius.nkp.cz/
3:ABA013:N??rodn?? technick?? knihovna:http\://kramerius.stk.cz/
3:ABC135:N??rodn?? filmov?? archiv v Praze:http\://kramerius.nfa.cz/
3:ABE304:Institut um??n?? ??? Divadeln?? ??stav:http\://kramerius.divadlo.cz/
3:ABG001:Digit??ln?? knihovna M??stsk?? knihovny v Praze:http\://kramerius.mlp.cz/
3:BOD006:Mendelova univerzita v Brn??:http\://kramerius.mendelu.cz
3:CBA001:Jiho??esk?? v??deck?? knihovna v ??esk??ch Bud??jovic??ch:http\://kramerius.cbvk.cz
3:OLA001:Digitaln?? knihovna novin:http\://noviny.vkol.cz/
3:OSA001:Moravskoslezsk?? v??deck?? knihovna v Ostrav??:http\://camea.svkos.cz
3:PNA001:Studijn?? a v??deck?? knihovna Plze??sk??ho kraje:http\://kramerius.svkpl.cz/
3:ULG001:Severo??esk?? v??deck?? knihovna v ??st?? nad Labem:http\://kramerius.svkul.cz
3:ZLG001b:Krajsk?? knihovna Franti??ka Barto??e ve Zl??n??:http\://dlib.kfbz.cz
4:mzk:Moravsk?? zemsk?? knihovna:http\://kramerius.mzk.cz/
4:ndk:N??rodn?? digit??ln?? knihovna:http\://ndk.cz/
4:vkol:V??deck?? knihovna v Olomouci:http\://kramerius.kr-olomoucky.cz/
4:svkhk:Studijn?? a v??deck?? knihovna v Hradci Kr??lov??:http\://kramerius4.svkhk.cz/
4:svkul:Severo??esk?? v??deck?? knihovna v ??st?? nad Labem:http\://kramerius.svkul.cz/
4:knav:Knihovna Akademie v??d ??R:https\://kramerius.lib.cas.cz/
4:mkct:M??stsk?? knihovna ??esk?? T??ebov??:http\://k5.digiknihovna.cz/
4:dsmo:Digit??ln?? studovna Ministerstva obrany ??R:https\://kramerius.army.cz/
4:mlp:M??stsk?? knihovna v Praze:http\://kramerius4.mlp.cz/
4:kkkv:Krajsk?? knihovna Karlovy Vary:http\://k4.kr-karlovarsky.cz/
4:kvkli:Krajsk?? v??deck?? knihovna Liberec:http\://kramerius.kvkli.cz/
4:svkpk:Studijn?? a v??deck?? knihovna Plze??sk??ho kraje:http\://k4.svkpl.cz/
4:nfa:N??rodn?? filmov?? archiv:http\://library.nfa.cz/
4:zmp:??idovsk?? muzeum v Praze:http\://kramerius4.jewishmuseum.cz/
4:nm:N??rodn?? muzeum:http\://kramerius.nm.cz/
4:zcm:Knihovna Z??pado??esk??ho muzea v Plzni:http\://kramerius.zcm.cz/
4:cbvk:Jiho??esk?? v??deck?? knihovna v ??esk??ch Bud??jovic??ch:http\://kramerius.cbvk.cz/
4:kfbz:Krajsk?? knihovna Franti??ka Barto??e ve Zl??n??:http\://dlib.kfbz.cz/
4:nkp:N??rodn?? knihovna:http\://kramerius5.nkp.cz/
4:cuni_fsv:Univerzita Karlova v Praze - Fakulta soci??ln??ch v??d:http\://kramerius.fsv.cuni.cz/
4:ntk:N??rodn?? technick?? knihovna:http\://kramerius.techlib.cz/
4:svkkl:St??edo??esk?? v??deck?? knihovna v Kladn??:http\://kramerius.svkkl.cz/
4:lmda:Lesnick?? a mysliveck?? digit??ln?? archiv:http\://lmda.silvarium.cz/
4:uzei:Knihovna Anton??na ??vehly:http\://kramerius.uzei.cz/
4:ukb:Univerzitn?? kni??nica v Bratislave:http\://pc139.ulib.sk/
4:slu:Slezsk?? univerzita v Opav??:http\://kramerius.slu.cz/
4:svkos:Moravskoslezsk?? v??deck?? knihovna v Ostrav??:http\://camea.svkos.cz/
4:vugtk:V??zkumn?? ??stav geodetick??, topografick?? a kartografick??:http\://knihovna-test.vugtk.cz/
4:vse:Vysok?? ??kola ekonomick?? v Praze:http\://kramerius.vse.cz/
4:nlk:N??rodn?? l??ka??sk?? knihovna v Praze:https\://kramerius.medvik.cz/
4:mendelu:Mendelova univerzita v Brn??:http\://kramerius4.mendelu.cz/
4:kkvhb:Krajsk?? knihovna Vyso??iny v Havl????kov?? Brod??:http\://kramerius.kkvysociny.cz/
4:cdk:??esk?? Digit??ln?? knihovna:http\://cdk.lib.cas.cz/
4:nmzv:N??rodn?? muzeum - Zvuk:http\://kramerius.nm.cz/
4:npmk:N??rodn?? pedagogick?? muzeum J. A. Komensk??ho:https\://kramerius.npmk.cz/
4:nulk:N??rodn?? ??stav lidov?? kultury:https\://kramerius.nulk.cz/
4:hmt:Husitsk?? muzeum v T??bo??e:http\://kramerius.husitskemuzeum.cz/
