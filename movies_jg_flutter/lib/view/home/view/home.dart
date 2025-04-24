import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_jg_flutter/core/core.dart';
import 'package:movies_jg_flutter/view/home/bloc/bloc_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BlocCubit bloc;
  bool isFavoritesFiltered = false;
  
  @override
  void initState() {
    super.initState();
    bloc = AppGetIt.instance.get<BlocCubit>();
    bloc.movies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2cd3c3),
        appBar: AppBar(
          toolbarHeight: 10,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<BlocCubit, BlocState>(
          builder: (context, state) {
            if (state is BlocSuccess) {
              final movies = state.entity!.data?.movies ?? [];

              return Column(
                children: [
                  Image.asset('assets/logo.png', width: MediaQuery.of(context).size.width * 0.5,), 
                  const Text("MoviesJG", style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF212322),
                    fontWeight: FontWeight.bold
                    
                  ),),
                  Expanded(
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        final title = movie.properties?.title ?? 'Sem título';
                        final released = movie.properties?.released ?? 'NaN';
                        final directorNames =
                            movie.directors?.map((a) => a.name).join(', ') ??
                                'Sem atores';

                        return GestureDetector(
                          onTap: () => showMovieDetailsDialog(context, movie),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(title),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(released.toString()),
                                  const Spacer(),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (directorNames.isNotEmpty)
                                    Text(directorNames)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}

void showMovieDetailsDialog(BuildContext context, Movies movie) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Detalhes do Filme',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                movie.properties?.title ?? 'Título não disponível',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              Text(
                'Data de lançamento: ${movie.properties?.released ?? 'Data não disponível'}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              Text(
                'Tagline: ${movie.properties?.tagline ?? 'Tagline não disponível'}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              if (movie.actors != null && movie.actors!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Atores:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...movie.actors!.map((actor) {
                      return Text(
                        '${actor.name}, Nascido em: ${actor.born}',
                        textAlign: TextAlign.center,
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                ),

              if (movie.directors != null && movie.directors!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Diretores:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...movie.directors!.map((director) {
                      return Text(
                        '${director.name}, Nascido em: ${director.born}',
                        textAlign: TextAlign.center,
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                ),
            ],
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ),
        ],
      );
    },
  );
}
